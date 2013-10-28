      NAME  KEYPAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                    KEYPAD                                  ;
;                                                                           ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Description:      This file stores keypad routines.
;
; Revision History:
;    02/28/08  Nadine Dabby      initial revision 
;    03/2/08  Nadine Dabby     debugging
;   03/05/08    Nadine Dabby    debugging

; local include files
$INCLUDE(EH.INC)
$INCLUDE(KEYPAD.INC)


CGROUP  GROUP   CODE
DGROUP  GROUP   DATA


CODE    SEGMENT PUBLIC 'CODE'


EXTRN   KeyTable:BYTE
        ASSUME  CS:CGROUP, DS:DGROUP



;GetKey()
;
;Description:         This function is called with no arguments and returns with
;the code for the key pressed on the keypad in register AL. The procedure
;will only return fully debounced key presses. The routine returns with the
;key code after the key has been pressed and debounced, but not necessarily
;released. The procedure does not return until a key has been pressed.
;
;Pseudocode:                REPEAT
 ;                               Call IsAKey()
  ;                      UNTIL (ZeroFlag = 0)
   ;                     AL = KEY_CODE
    ;                    RETURN
;
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        KEY_CODE, KEY_FLAG
;
;Local Variables:         KEY_CODE, KEY_FLAG
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        There is no key buffer as of now. The system will respond to
;only one Key at a time and will ignore Multiple keys pressed at the same
;time.
;
;Known Bugs:         None
;
;Special Notes:         None
;
;

GetKey       PROC    NEAR
                  PUBLIC GetKey
     
          WaitingToGetKey:               ;		REPEAT
            CALL IsAKey     ;			IsAKey(a)
            JE WaitingToGetKey
            ;JMP  GettingKey    ;		UNTIL ( ZeroFlag = 1)
    GettingKey:
            MOV AL, KEY_CODE
            MOV KEY_FLAG, 0
         
            RET
        
GetKey        ENDP



;IsAKey()
;
;Description:         The function is called with no arguments and returns with
;the zero flag reset if there is a key available and the zero flag set
;otherwise.
;
;Pseudocode:        If (KEY_FLAG = 0)
;                        ZeroFlag = 1
;                ELSE ZeroFlag = 0
;
;Arguments:         None
;
;Return Values:         None
;g

;Global Variables:         None
;
;Shared Variables:        KEY_CODE, KEY_FLAG
;
;Local Variables:         KEY_CODE, KEY_FLAG
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        There is no key buffer as of now. The system will respond to
;only one Key at a time and will ignore Multiple keys pressed at the same
;time.
;
;Known Bugs:         None
;
;Special Notes:         None
;
IsAKey       PROC    NEAR
             PUBLIC IsAKey
            
            CMP KEY_FLAG, 0           ;sets zero flag if KEY_FLAG = 0
                                    ;Otherwise clears it --> key available
            RET
        
IsAKey        ENDP

;
;KeyScanDebounce()
;
;Description:         The keypad scanning and debouncing function (which is 
;called by the timer event handler). This function should be called approximately
;every millisecond. It either checks for a new key being pressed if none is
;currently pressed or debounces the currently pressed key. Once it has a
;debounced key it should set a local flag (used by IsAKey and GetKey) and
;store the key code in a local variable (used by GetKey).
;
;Pseudocode:            
;                       IF (SWITCHUP = 1)
;                       THEN         DebounceCounter = DEBOUNCE_TIME.
                            ;       INCREMENT ROW_COUNTER
                            ;       ROW_COUNTER = ROW_COUNTER MOD 4
                            ;       DEBOUNCE_ROW = 80 + Row_Counter
;                        ELSE 
;                               DebounceCounter--
;                               IF (Debounce_Counter ==0)
;                               THEN KEYFLAG = 0
  ;                                  DebounceCounter = DEBOUNCE_TIME
  ;                             ENDIF
        ;               ENDIF
    ;                    RETURN
;

;IN 80 84 hex
;
;Arguments:
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        KEY_CODE, KEY_FLAG
;
;Local Variables:         KEY_CODE, KEY_FLAG
;
;Inputs:         None
;
;Outputs:
;
;Error handling:
;
;Algorithms:        None
;
;Data Structures:
;
;Limitations:        There is no key buffer as of now. The system will respond to
;only one Key at a time and will ignore Multiple keys pressed at the same time.
;
;Known Bugs:         None
;
;Special Notes:



KeyScanDebounce       PROC    NEAR
                      PUBLIC  KeyScanDebounce

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX
            
            MOV  BX, OFFSET(KeyTable) ;and lookup the pattern 
            MOV DX, DEBOUNCE_ROW
            IN AL, DX
            NOT AL
            AND AL, KEYSCAN_MASK
            MOV DX, ROW_COUNTER
            XLAT CS:KeyTable
            MOV AH, 0
            ;ADD AX, DX 
            CMP AL, 0
            JE NoKey
            MOV BX, AX
            IMUL DX, DX, 4
            ADD AX, DX
            MOV KEY_CODE, AL
            ;JMP HaveKey
        HaveKey:
            MOV BX, DEBOUNCE_COUNTER
            DEC BX
            CMP BX, 0
            JE DoneDebouncing
            MOV DEBOUNCE_COUNTER, BX
            JMP EndDebounce
            
        DoneDebouncing:
            MOV KEY_FLAG, 1
            MOV BX, AUTO_REPEAT
            MOV DEBOUNCE_COUNTER, BX
            JMP EndDebounce
            
        NoKey:
            MOV BX, DEBOUNCE_TIME
            MOV DEBOUNCE_COUNTER, BX
            MOV AX, ROW_COUNTER
            INC AX
            MOV CX, 4
            MOV DX, 0
            IDIV CX
            MOV ROW_COUNTER, DX
            ADD DX, 80H
            MOV DEBOUNCE_ROW, DX
            ;JMP EndDebounce
        EndDebounce:
            POP DX
            POP CX
            POP BX
            POP AX
            RET
        
KeyScanDebounce        ENDP



;
;KeyInit()
;
;Description:         This function initializes the KeyPad shared variables
;(KEY_CODE and KEY_FLAG) as well as the global timer variables
;KeyTimerCount and KeyMaxCount.
;
;Pseudocode:                KeyTimerCount = 0
;KeyMaxCount = 1 millisecond
;KEY_FLAG = 0
;KEY_CODE = 11111; (no key)
;
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         KeyTimerCount for keypad, KeyMaxCount.
;
;Shared Variables:        KEY_CODE, KEY_FLAG
;
;Local Variables:         KEY_CODE, KEY_FLAG
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;

KeyInit       PROC    NEAR
              PUBLIC  KeyInit
        PUSH AX
        MOV AX, DEBOUNCE_TIME
        MOV DEBOUNCE_COUNTER,AX
        MOV ROW_COUNTER, 0
        MOV AX, 0
        ADD AX, 80H
        MOV DEBOUNCE_ROW, AX
        MOV KEY_FLAG, 0             ;zero indicates no key
        MOV KEY_CODE, 00000000B
        POP AX
        RET
        
KeyInit        ENDP



CODE ENDS

DATA    SEGMENT PUBLIC  'DATA'

ROW_COUNTER     DW          ?
DEBOUNCE_ROW    DW          ?
DEBOUNCE_COUNTER DW         ?
KEY_CODE        DB        ? 
KEY_FLAG        DB          ?

DATA    ENDS



       END    
