NAME HW13LOOP
;
;Main Loop to test serial
;Revision History
;   2/17/08 Nadine Dabby    Written and Debugged
;   3/18/08 Nadine Dabby    rewritten to test serial
;


CGROUP  GROUP   CODE
DGROUP  GROUP   DATA, STACK



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP, SS:DGROUP



;external function declarations

;EXTRN InitDisplay:NEAR
;EXTRN KeyInit:NEAR               
EXTRN ChipInit:NEAR
EXTRN ParseTest:NEAR
EXTRN PInit:NEAR

START: 
MAIN:
        CLI
        MOV     AX, DGROUP               ;initialize the stack pointer
        MOV     SS, AX
        MOV     SP, OFFSET(TopOfStack)

        MOV     AX, DGROUP                ;initialize the data segment
        MOV     DS, AX


        CALL    ChipInit
        CALL    PInit
        STI                             ;and finally allow interrupts.


        CALL    ParseTest           ;test parse
        
Forever:                 ;sit in an infinite loop, nothing to                   
       
       JMP    Forever 
       HLT                             ;never executed (hopefully)


CODE            ENDS


DATA    SEGMENT PUBLIC  'DATA'

DATA    ENDS

STACK    SEGMENT STACK 'STACK'
    
    DB 80 DUP ('STACK')
    TopOfStack LABEL WORD

STACK    ENDS

END     START