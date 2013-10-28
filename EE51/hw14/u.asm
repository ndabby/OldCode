NAME USER
       
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                   U.ASM                                        ;
;                                   USER INTERFACE                                 ;
;                   Driver for Parsing Serial Strings                ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the main functions for parsing ASCII serial strings
; The functions included are:
;    ParseSerialChar(c)	    - parse a character c as part of a serial command

; Revision History:
;     3/18/08  Nadine Dabby              wrote code



CGROUP  GROUP   CODE

CODE SEGMENT PUBLIC 'CODE'

        ASSUME  CS:CGROUP 

EXTRN PInit:NEAR
EXTRN SerialInRdy:NEAR
EXTRN ParseSerialChar:NEAR
EXTRN SetSerialBaudRate:NEAR
EXTRN SetSerialParity:NEAR
EXTRN SerialPutChar:NEAR
EXTRN SerialGetChar:NEAR
EXTRN IsAKey:NEAR
EXTRN GetKey:NEAR
EXTRN DisplayNum:NEAR
EXTRN DisplayHex:NEAR
EXTRN Display:NEAR
EXTRN NoOp:NEAR
EXTRN SetLaser:NEAR
EXTRN SetMotorSpeed:NEAR
EXTRN SetRelTurretAngle:NEAR

    
UI      PROC NEAR
        PUBLIC UI
        
  PushMyButton:
        POPA
        CALL IsAKey
        JNZ PushMyButton
       ; JMP GreatScottIveGotIt
       
   GreatScottIveGotIt:
        CALL GetKey
        MOV AH, 0
        CALL DisplayNum        
        SAL AX, 1
        MOV DX, AX
        MOV BP, OFFSET(UI_BXTable)
        ADD BP, DX
        MOV BX,  WORD PTR CS:[BP]
        MOV BP, OFFSET(UI_AXTable)
        ADD BP, DX
        MOV AX,  WORD PTR CS:[BP]
        MOV BP, OFFSET(UI_Table)
        ADD BP, DX
        MOV CX,  WORD PTR CS:[BP]
                CALL CX ;	
        PUSHA
        JMP PushMyButton;                       loop forever
        
UI      ENDP


EnableSerial    PROC NEAR
                PUBLIC EnableSerial
    CALL PInit; 
SerialLoopBack:                
    CALL SerialInRdy;if not check inrdy
    JNZ  NoInputYet
    CALL SerialGetChar
    CALL SerialPutChar ;echo
    ;JMP NoInputYet
NoInputYet:
    CALL ParseSerialChar
    CALL IsAKey
    JNZ SerialLoopBack
    CALL GetKey
    CMP AL, 0EH    ;Check if key is abort
    JNE SerialLoopBack
    RET
EnableSerial    ENDP




UI_Table       LABEL   Word
               PUBLIC  UI_Table

                ;       DW      address of function to call
              ;indexed by keystroke
			
        DW  OFFSET(NoOp); 00 Shouldn't get here
        DW  OFFSET(SetLaser); 01  Stop Fireing
        DW  OFFSET(SetLaser); 02 Fire!
        DW  OFFSET(SetMotorSpeed); 03 	move forward
        DW  OFFSET(SetMotorSpeed); 04 	move backward
        DW  OFFSET(SetMotorSpeed); 05   move right
        DW  OFFSET(SetMotorSpeed); 06   move left
        DW  OFFSET(SetRelTurretAngle); 07  move turret clockwise 45 degrees         
        DW  OFFSET(SetSerialBaudRate); 08     baud = 300       
        DW  OFFSET(SetSerialBaudRate); 09  baud = 9600
        DW  OFFSET(SetSerialBaudRate); 0A     baud = 57600     
        DW  OFFSET(SetSerialParity); 0b parity = none
        DW  OFFSET(SetSerialParity); 0c parity = 0dd
        DW  OFFSET(SetSerialParity); 0d  parity = even 
        DW  OFFSET(EnableSerial); 0e 
        DW  OFFSET(NoOp); 10      

        
UI_AXTable       LABEL   Word
               PUBLIC  UI_AXTable

                ;    AX Values
			
 
        DW  0; 01 disable laser 
        DW  1; 02 enable laser
        DW  65534; 03  Forward 
        DW  65534; 04  Reverse 
        DW  65534; 05
        DW  65534; 06 
        DW  45; 07         
        DW  1; 08   baud = 300          
        DW  4; 09   baud = 9600
        DW  6; 0A   baud = 57600      
        DW  0; 0b 
        DW  1; 0c
        DW  2; 0d  
        DW  0; 0e 
        DW  0; 10  

        
        
UI_BXTable       LABEL   Word
               PUBLIC  UI_BXTable

                ;    AX Values
			
 
        DW  0; 01 disable laser 
        DW  0; 02 enable laser
        DW  0; 03 
        DW  180; 04 
        DW  90; 05
        DW  270; 06 
        DW  0; 07         
        DW  0; 08          
        DW  0; 09 
        DW  0; 0A         
        DW  0; 0b 
        DW  0; 0c
        DW  0; 0d   
        DW  0; 0e 
        DW  0; 10       

CODE ENDS



        END
