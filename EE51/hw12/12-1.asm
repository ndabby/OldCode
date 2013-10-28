NAME HW12LOOP
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

EXTRN InitDisplay:NEAR
;EXTRN KeyInit:NEAR               
EXTRN ChipInit:NEAR
EXTRN SerialInit:NEAR
;EXTRN MotorInit:NEAR
EXTRN SerialIOTest:NEAR
EXTRN SerialPutChar:NEAR


START: 
MAIN:
        CLI
        MOV     AX, DGROUP               ;initialize the stack pointer
        MOV     SS, AX
        MOV     SP, OFFSET (DGROUP:TopOfStack)

        MOV     AX, DGROUP                ;initialize the data segment
        MOV     DS, AX


        CALL    ChipInit
        CALL    SerialInit
        CALL    InitDisplay
        ;CALL    KeyInit
        ;CALL    MotorInit
        STI                             ;and finally allow interrupts.


        CALL    SerialIOTest           ;test motors
        ;MOV AX, 'A'        
Forever:                 ;sit in an infinite loop, nothing to                   
        ;   do in the background routine

        ;CALL  SerialPutChar 
        
       
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