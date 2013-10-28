        NAME  Parse

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                    PARSE.ASM                                        ;
;                                   PARSE                                 ;
;                   Driver for Parsing Serial Strings                ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the main functions for parsing ASCII serial strings
; The functions included are:
;    ParseSerialChar(c)	    - parse a character c as part of a serial command

; Revision History:
;     3/18/08  Nadine Dabby              wrote code



; local include files
$INCLUDE(PARSE.INC)



CGROUP  GROUP   CODE
DGROUP  GROUP   DATA




CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP



; external action routines used by state machine
;   assumed to affect no registers


	EXTRN  SetMotorSpeed:NEAR		;
	EXTRN  SetTurretAngle:NEAR		;
	EXTRN  SetRelTurretAngle:NEAR		;
	EXTRN  SetLaser:NEAR		;
	EXTRN  GetMotorSpeed:NEAR		;
	EXTRN  GetMotorDirection:NEAR		;
	EXTRN  GetTurretAngle:NEAR		;
	EXTRN  GetLaser:NEAR		;
    
; ParseSerialChar(c)
;
; Description:      The function is passed a character (c) which is presumed to 
;be from the serial input. This character should be processed as a serial 
;command. The character (c) is passed by value in AL. The function returns the 
;status of the parsing operation in AX. Zero (0) is returned if there are no 
;parsing errors due to the passed character and a non-zero value is returned if 
;there is a parsing error due to the passed character.
;
; Operation:        Uses a state machine to translate the string.  The
;                   function loops, processing characters until either the
;                   end state or error state is reached.  At that point it
;                   returns with an appropriate value.
;
; Arguments:        AL holds char to be parsed
; Return Value:     AX is returned with parse status
;
; Local Variables:  
;
; Shared Variables: None.
; Global Variables: None.
;
; Input:            None.
; Output:           None.
;
; Error Handling:   
;
; Algorithms:       State Machine.
; Data Structures:  Token Table, State Table
;
; Registers Used:   
; Stack Depth:      
;
; Author:           Nadine Dabby
; Last Modified:    March 19, 2008

ParseSerialChar		PROC    NEAR
                PUBLIC  ParseSerialChar


InitParsing:				;setup the state machine
    MOV	CL, State		;start in the initial state

DoNextToken:				;get next input for state machine
	;MOV	AL, [DI]		;get the input
	CALL	GetToken		;and get the token type and value
	MOV	DH, AH			;and save them in DH and CH
	MOV	CH, AL

ComputeTransition:			;figure out what transition to do
	MOV	AL, NUM_TOKEN_TYPES	;find row in the table
	MUL	CL			;AX is start of row for current state
	ADD	AL, DH			;get the actual transition
	ADC	AH, 0			;propagate low byte carry into high byte

	IMUL	BX, AX, SIZE TRANSITION_ENTRY   ;now convert to table offset

DoActions:				;do the actions (don't affect regs)
	MOV	AL, CH			;get token value back for actions
	CALL	CS:StateTable[BX].ACTION1	;do the actions
	CALL	CS:StateTable[BX].ACTION2
	CALL	CS:StateTable[BX].ACTION3

DoTransition:				;now go to next state
	MOV	CL, CS:StateTable[BX].NEXTSTATE
	MOV State, CL
    ;INC	DI			;and next character in string
    ;JMP	StateMachineLoop	;do another transition...

StateMachineEnd:			;all done with state machine
	;JMP	EndParse		;so done with parsing

EndParse:		;done parsing return with value
       RET


ParseSerialChar		ENDP

;init parse

PInit      PROC NEAR
            PUBLIC PInit
           MOV State, ST_INITIAL
            RET
PInit              ENDP

;function to put 0 in AX

PutAX0              PROC NEAR
                    PUBLIC PutAX0
            MOV AX, 0
            RET
PutAX0              ENDP

;function to put 1 in AX

PutAX1              PROC NEAR
                    PUBLIC PutAX1
            MOV AX, 1
            RET        
PutAX1              ENDP

ClearCX               PROC NEAR
                    PUBLIC ClearCX
           MOV CX, 0 
           RET        
ClearCX              ENDP

;function to compute digit ;;;;;note:need to deal with overflow
;AL has new digit
;store total number in CX
;all positive numbers, will compute sign last

ComputeNumber              PROC NEAR
                    PUBLIC ComputeNumber
            PUSH AX
            MOV AX, CX
            MOV CX, 10
            MUL CX
            MOV CX, AX
            POP AX
            MOV AH, 0
            ADD CX, AX 
            RET        
ComputeNumber              ENDP


SetAbsSpeed              PROC NEAR
                    PUBLIC SetAbsSpeed
            PUSH BX
            CALL GetMotorDirection
            MOV BX, AX
            MOV AX, CX
            CALL SetMotorSpeed
            POP BX
            RET        
SetAbsSpeed              ENDP


SetRelSpeed              PROC NEAR
                    PUBLIC SetRelSpeed
            PUSH BX
            CALL GetMotorDirection
            MOV BX, AX
            CALL GetMotorSpeed
            ADD AX, CX
            CMP AX, 0
            JL BadSpeed
            CALL SetMotorSpeed 
            JMP EndSetRelSpeed
    BadSpeed: MOV AX, 1
            ;JMP EndSetRelSpeed
    EndSetRelSpeed:
            POP BX
            RET        
SetRelSpeed              ENDP

SetDir              PROC NEAR
                    PUBLIC SetDir
            PUSH BX
            CALL GetMotorSpeed
            MOV BX, CX
            CALL SetMotorSpeed
            POP BX
            RET        
SetDir              ENDP  

SetUpTur              PROC NEAR
                    PUBLIC SetUpTur
            MOV AX, CX
            RET        
SetUpTur              ENDP  

SetUpNegTur              PROC NEAR
                    PUBLIC SetUpNegTur
            NEG CX
            MOV AX, CX
            RET        
SetUpNegTur              ENDP  


MakeNegative        PROC NEAR
                    PUBLIC MakeNegative
            NEG CX 
            RET        
MakeNegative              ENDP

NoOp        PROC NEAR
                    PUBLIC NoOp
            RET        
NoOp             ENDP

; StateTable
;
; Description:      This is the state transition table for the state machine.
;                   Each entry consists of the next state and actions for that
;                   transition.  The rows are associated with the current
;                   state and the columns with the input type.
;
; Author:           Nadine Dabby
; Last Modified:    March 18, 2008


TRANSITION_ENTRY        STRUC           ;structure used to define table
    NEXTSTATE   DB      ?               ;the next state for the transition
    ACTION1     DW      ?               ;first action for the transition
    ACTION2     DW      ?               ;second action for the transition
    ACTION3     DW      ?               ;third action
TRANSITION_ENTRY      ENDS


;define a macro to make table a little more readable
;macro just does an offset of the action routine entries to build the STRUC
%*DEFINE(TRANSITION(nxtst, act1, act2, act3))  (
    TRANSITION_ENTRY< %nxtst, OFFSET(%act1), OFFSET(%act2), OFFSET(%act3) >
)


StateTable	LABEL	TRANSITION_ENTRY

	;Current State = ST_INITIAL                      Input Token Type
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_MINUS     
	%TRANSITION(ST_S1, NoOp, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_V1, NoOp, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_D1, NoOp, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_T1, NoOp, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, SetLaser, PutAX0)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX0, SetLaser, PutAX0)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER

	;Current State = ST_S1                      Input Token Type
	%TRANSITION(ST_S_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_S1_PLUS, NoOp, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER


	;Current State = ST_S1_PLUS                      Input Token Type
	%TRANSITION(ST_S_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PUTAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER

    	;Current State = ST_S_DIGIT                      Input Token Type
        ;not set up to fix overflow yet
	%TRANSITION(ST_S_DIGIT, ComputeNumber, NoOp, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PUTAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetAbsSpeed, PutAX0, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER
    
 	;Current State = ST_V1                      Input Token Type
	%TRANSITION(ST_V_POS_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_V1_PLUS, NoOp, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_V1_MINUS, NoOp, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   
    
    ;Current State = ST_V1_PLUS                      Input Token Type
	%TRANSITION(ST_V_POS_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   
    
     	;Current State = ST_V1_MINUS                      Input Token Type
	%TRANSITION(ST_V_NEG_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   

        ;Current State = ST_V_POS_DIGIT                      Input Token Type
	%TRANSITION(ST_V_POS_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetRelSpeed, PutAX0, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   
    
    ; dealing with abs speed < 0 in setrelspeed
    ;Current State = ST_V_NEG_DIGIT                      Input Token Type
	%TRANSITION(ST_V_NEG_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, MakeNegative, PutAX0, SetRelSpeed)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER      
    
  	;Current State = ST_D1                      Input Token Type
	%TRANSITION(ST_D_POS_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_D1_PLUS, NoOp, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_D1_MINUS, NoOp, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER      
    
    ;Current State = ST_D1_PLUS                      Input Token Type
	%TRANSITION(ST_D_POS_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER    

     	;Current State = ST_D1_MINUS                      Input Token Type
	%TRANSITION(ST_D_NEG_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER     

        ;Current State = ST_D_POS_DIGIT                      Input Token Type
	%TRANSITION(ST_D_POS_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetDir, PutAX0, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   
    
    ; dealing with abs speed < 0 in 
    ;Current State = ST_D_NEG_DIGIT                      Input Token Type
	%TRANSITION(ST_D_NEG_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, MakeNegative, SetDir, PutAX0)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER        

  	;Current State = ST_T1                      Input Token Type
	%TRANSITION(ST_T_NOSIGN_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_T_PLUS, NoOp, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_T_MINUS, NoOp, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER      

    ;Current State = ST_T1_PLUS                      Input Token Type
	%TRANSITION(ST_T_POS_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER    

     	;Current State = ST_T1_MINUS                      Input Token Type
	%TRANSITION(ST_T_NEG_DIGIT, ClearCX, ComputeNumber, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER     

    ;Current State = ST_T_NOSIGN_DIGIT                      Input Token Type
	%TRANSITION(ST_T_NOSIGN_DIGIT, ComputeNumber, NoOp, NoOp)	;TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetUpTur, SetRelTurretAngle, PutAX0)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER    

        ;Current State = ST_T_POS_DIGIT                      Input Token Type
	%TRANSITION(ST_T_POS_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)      ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetUpTur, SetTurretAngle, PutAX0)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   
    
    ; dealing with abs speed < 0 in 
    ;Current State = ST_T_NEG_DIGIT                      Input Token Type
	%TRANSITION(ST_T_NEG_DIGIT, ComputeNumber, NoOp, NoOp);TOKEN_DIGIT
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)   ;TOKEN_PLUS
 	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)       ;TOKEN_MINUS   
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_S
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_V
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_D
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_T
    %TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	    ;TOKEN_F
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)		;TOKEN_0
	%TRANSITION(ST_INITIAL, SetUpNegTur, SetTurretAngle, PutAX0)   ;TOKEN_EOS
	%TRANSITION(ST_INITIAL, PutAX1, NoOp, NoOp)	;TOKEN_OTHER   

    ; GetToken
;
; Description:      This procedure returns the token class and token value for
;                   the passed character.  
;
; Operation:        Looks up the passed character in two tables, one for token
;                   types or classes, the other for token values.
;
; Arguments:        AL - character to look up.
; Return Value:     AL - token value for the character.
;                   AH - token type or class for the character.
;
; Local Variables:  BX - table pointer, points at lookup tables.
; Shared Variables: None.
; Global Variables: None.
;
; Input:            None.
; Output:           None.
;
; Error Handling:   None.
;
; Algorithms:       Table lookup.
; Data Structures:  Two tables, one containing token values and the other
;                   containing token types.
;
; Registers Used:   AX, BX.
; Stack Depth:      0 words.
;
; Author:           Glen George
; Last Modified:    Feb. 26, 2003
;                   Nadine Dabby, 3/18/08 modified to use for command parse

GetToken	PROC    NEAR
                PUBLIC GetToken


InitGetToken:				;setup for lookups
	MOV	AH, AL			;and preserve value in AH

TokenTypeLookup:                        ;get the token type
    MOV     BX, OFFSET(TokenTypeTable)  ;BX points at table
	XLAT	CS:TokenTypeTable	;have token type in AL
	XCHG	AH, AL			;token type in AH, character in AL

TokenValueLookup:			;get the token value
        MOV     BX, OFFSET(TokenValueTable)  ;BX points at table
	XLAT	CS:TokenValueTable	;have token value in AL


EndGetToken:                     	;done looking up type and value
        RET


GetToken	ENDP




; Token Tables
;
; Description:      This creates the tables of token types and token values.
;                   Each entry corresponds to the token type and the token
;                   value for a character.  Macros are used to actually build
;                   two separate tables - TokenTypeTable for token types and
;                   TokenValueTable for token values.
;
; Author:           Glen George
; Last Modified:    Feb. 26, 2003

%*DEFINE(TABLE)  (
        %TABENT(TOKEN_EOS, 0)		;<null>  (end of string)
        %TABENT(TOKEN_OTHER, 1)		;SOH
        %TABENT(TOKEN_OTHER, 2)		;STX
        %TABENT(TOKEN_OTHER, 3)		;ETX
        %TABENT(TOKEN_OTHER, 4)		;EOT
        %TABENT(TOKEN_OTHER, 5)		;ENQ
        %TABENT(TOKEN_OTHER, 6)		;ACK
        %TABENT(TOKEN_OTHER, 7)		;BEL
        %TABENT(TOKEN_OTHER, 8)		;backspace
        %TABENT(TOKEN_OTHER, 9)		;TAB
        %TABENT(TOKEN_OTHER, 10)	;new line
        %TABENT(TOKEN_OTHER, 11)	;vertical tab
        %TABENT(TOKEN_OTHER, 12)	;form feed
        %TABENT(TOKEN_OTHER, 13)	;carriage return
        %TABENT(TOKEN_OTHER, 14)	;SO
        %TABENT(TOKEN_OTHER, 15)	;SI
        %TABENT(TOKEN_OTHER, 16)	;DLE
        %TABENT(TOKEN_OTHER, 17)	;DC1
        %TABENT(TOKEN_OTHER, 18)	;DC2
        %TABENT(TOKEN_OTHER, 19)	;DC3
        %TABENT(TOKEN_OTHER, 20)	;DC4
        %TABENT(TOKEN_OTHER, 21)	;NAK
        %TABENT(TOKEN_OTHER, 22)	;SYN
        %TABENT(TOKEN_OTHER, 23)	;ETB
        %TABENT(TOKEN_OTHER, 24)	;CAN
        %TABENT(TOKEN_OTHER, 25)	;EM
        %TABENT(TOKEN_OTHER, 26)	;SUB
        %TABENT(TOKEN_OTHER, 27)	;escape
        %TABENT(TOKEN_OTHER, 28)	;FS
        %TABENT(TOKEN_OTHER, 29)	;GS
        %TABENT(TOKEN_OTHER, 30)	;AS
        %TABENT(TOKEN_OTHER, 31)	;US
        %TABENT(TOKEN_OTHER, ' ')	;space
        %TABENT(TOKEN_OTHER, '!')	;!
        %TABENT(TOKEN_OTHER, '"')	;"
        %TABENT(TOKEN_OTHER, '#')	;#
        %TABENT(TOKEN_OTHER, '$')	;$
        %TABENT(TOKEN_OTHER, 37)	;percent
        %TABENT(TOKEN_OTHER, '&')	;&
        %TABENT(TOKEN_OTHER, 39)	;'
        %TABENT(TOKEN_OTHER, 40)	;open paren
        %TABENT(TOKEN_OTHER, 41)	;close paren
        %TABENT(TOKEN_OTHER, '*')	;*
        %TABENT(TOKEN_PLUS, +1)		;+  (positive sign)
        %TABENT(TOKEN_OTHER, 44)	;,
        %TABENT(TOKEN_MINUS, -1)		;-  (negative sign)
        %TABENT(TOKEN_OTHER, '.')		;.  (decimal point)
        %TABENT(TOKEN_OTHER, '/')	;/
        %TABENT(TOKEN_DIGIT, 0)		;0  (digit)
        %TABENT(TOKEN_DIGIT, 1)		;1  (digit)
        %TABENT(TOKEN_DIGIT, 2)		;2  (digit)
        %TABENT(TOKEN_DIGIT, 3)		;3  (digit)
        %TABENT(TOKEN_DIGIT, 4)		;4  (digit)
        %TABENT(TOKEN_DIGIT, 5)		;5  (digit)
        %TABENT(TOKEN_DIGIT, 6)		;6  (digit)
        %TABENT(TOKEN_DIGIT, 7)		;7  (digit)
        %TABENT(TOKEN_DIGIT, 8)		;8  (digit)
        %TABENT(TOKEN_DIGIT, 9)		;9  (digit)
        %TABENT(TOKEN_OTHER, ':')	;:
        %TABENT(TOKEN_OTHER, ';')	;;
        %TABENT(TOKEN_OTHER, '<')	;<
        %TABENT(TOKEN_OTHER, '=')	;=
        %TABENT(TOKEN_OTHER, '>')	;>
        %TABENT(TOKEN_OTHER, '?')	;?
        %TABENT(TOKEN_OTHER, '@')	;@
        %TABENT(TOKEN_OTHER, 'A')	;A
        %TABENT(TOKEN_OTHER, 'B')	;B
        %TABENT(TOKEN_OTHER, 'C')	;C
        %TABENT(TOKEN_D, 'D')	;D
        %TABENT(TOKEN_OTHER, 'E')		;E  (exponent indicator)
        %TABENT(TOKEN_F, 'F')	;F
        %TABENT(TOKEN_OTHER, 'G')	;G
        %TABENT(TOKEN_OTHER, 'H')	;H
        %TABENT(TOKEN_OTHER, 'I')	;I
        %TABENT(TOKEN_OTHER, 'J')	;J
        %TABENT(TOKEN_OTHER, 'K')	;K
        %TABENT(TOKEN_OTHER, 'L')	;L
        %TABENT(TOKEN_OTHER, 'M')	;M
        %TABENT(TOKEN_OTHER, 'N')	;N
        %TABENT(TOKEN_O, 'O')	;O
        %TABENT(TOKEN_OTHER, 'P')	;P
        %TABENT(TOKEN_OTHER, 'Q')	;Q
        %TABENT(TOKEN_OTHER, 'R')	;R
        %TABENT(TOKEN_S, 'S')	;S
        %TABENT(TOKEN_T, 'T')	;T
        %TABENT(TOKEN_OTHER, 'U')	;U
        %TABENT(TOKEN_V, 'V')	;V
        %TABENT(TOKEN_OTHER, 'W')	;W
        %TABENT(TOKEN_OTHER, 'X')	;X
        %TABENT(TOKEN_OTHER, 'Y')	;Y
        %TABENT(TOKEN_OTHER, 'Z')	;Z
        %TABENT(TOKEN_OTHER, '[')	;[
        %TABENT(TOKEN_OTHER, '\')	;\
        %TABENT(TOKEN_OTHER, ']')	;]
        %TABENT(TOKEN_OTHER, '^')	;^
        %TABENT(TOKEN_OTHER, '_')	;_
        %TABENT(TOKEN_OTHER, '`')	;`
        %TABENT(TOKEN_OTHER, 'a')	;a
        %TABENT(TOKEN_OTHER, 'b')	;b
        %TABENT(TOKEN_OTHER, 'c')	;c
        %TABENT(TOKEN_OTHER, 'd')	;d
        %TABENT(TOKEN_OTHER, 'e')		;e  (exponent indicator)
        %TABENT(TOKEN_OTHER, 'f')	;f
        %TABENT(TOKEN_OTHER, 'g')	;g
        %TABENT(TOKEN_OTHER, 'h')	;h
        %TABENT(TOKEN_OTHER, 'i')	;i
        %TABENT(TOKEN_OTHER, 'j')	;j
        %TABENT(TOKEN_OTHER, 'k')	;k
        %TABENT(TOKEN_OTHER, 'l')	;l
        %TABENT(TOKEN_OTHER, 'm')	;m
        %TABENT(TOKEN_OTHER, 'n')	;n
        %TABENT(TOKEN_OTHER, 'o')	;o
        %TABENT(TOKEN_OTHER, 'p')	;p
        %TABENT(TOKEN_OTHER, 'q')	;q
        %TABENT(TOKEN_OTHER, 'r')	;r
        %TABENT(TOKEN_OTHER, 's')	;s
        %TABENT(TOKEN_OTHER, 't')	;t
        %TABENT(TOKEN_OTHER, 'u')	;u
        %TABENT(TOKEN_OTHER, 'v')	;v
        %TABENT(TOKEN_OTHER, 'w')	;w
        %TABENT(TOKEN_OTHER, 'x')	;x
        %TABENT(TOKEN_OTHER, 'y')	;y
        %TABENT(TOKEN_OTHER, 'z')	;z
        %TABENT(TOKEN_OTHER, '{')	;{
        %TABENT(TOKEN_OTHER, '|')	;|
        %TABENT(TOKEN_OTHER, '}')	;}
        %TABENT(TOKEN_OTHER, '~')	;~
        %TABENT(TOKEN_OTHER, 127)	;rubout
)

; token type table - uses first byte of macro table entry
%*DEFINE(TABENT(tokentype, tokenvalue))  (
        DB      %tokentype
)

TokenTypeTable	LABEL   BYTE
        %TABLE


; token value table - uses second byte of macro table entry
%*DEFINE(TABENT(tokentype, tokenvalue))  (
        DB      %tokenvalue
)

TokenValueTable	LABEL       BYTE
        %TABLE



CODE ENDS

DATA    SEGMENT PUBLIC 'DATA'

State   DB ?

DATA ENDS


        END
