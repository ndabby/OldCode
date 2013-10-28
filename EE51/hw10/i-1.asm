       NAME  INIT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  INIT.ASM                                ;
;                                   Initialization code                        ;
;                                                                      ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the initalization functions.
;
; Revision History:
;     3/15/08 Nadine Dabby      Initial Version

;$INCLUDE(EH.INC)
$INCLUDE(8255.INC)

CGROUP  GROUP   CODE

CODE SEGMENT PUBLIC 'CODE'

        ASSUME  CS:CGROUP     
;external function declarations

EXTRN InitCS:NEAR
EXTRN ClrIRQVectors:NEAR
EXTRN InstallHandler:NEAR
EXTRN InitTimer:NEAR

ChipInit       PROC    NEAR
               PUBLIC  ChipInit

        CALL    InitCS                  ;initialize the 80188 chip selects
                                        ;   assumes LCS and UCS already setup

        CALL    ClrIRQVectors           ;clear (initialize) interrupt vector table

                                        
        CALL    InstallHandler          ;install the event handler
                                        ;   ALWAYS install handlers before
                                        ;   allowing the hardware to interrupt.

        CALL    InitTimer               ;initialize the internal timer
        
        PUSH AX
        PUSH DX
        XOR AH, AH
        MOV AL, CONTROL_WORD_8255
        MOV DX, CONTROL_ADDRESS_8255
        OUT DX, AL
        POP DX
        POP AX
        
    
        RET

ChipInit          ENDP

CODE      ENDS
      
      END