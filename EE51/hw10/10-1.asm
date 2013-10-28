NAME HW10LOOP
;
;Main Loop to test Motors
;Revision History
;   2/17/08 Nadine Dabby    Written and Debugged
;
;


CGROUP  GROUP   CODE
DGROUP  GROUP   DATA, STACK



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP, SS:DGROUP



;external function declarations

EXTRN InitDisplay:NEAR
EXTRN KeyInit:NEAR               
EXTRN ChipInit:NEAR
EXTRN MotorInit:NEAR
EXTRN MotorTest:NEAR


START: 
MAIN:
        CLI
        MOV     AX, DGROUP               ;initialize the stack pointer
        MOV     SS, AX
        MOV     SP, OFFSET(TopOfStack)

        MOV     AX, DGROUP                ;initialize the data segment
        MOV     DS, AX


        CALL    ChipInit
        CALL    InitDisplay
        CALL    KeyInit
        CALL    MotorInit
        STI                             ;and finally allow interrupts.


        CALL    MotorTest           ;test motors
        
Forever: JMP    Forever                 ;sit in an infinite loop, nothing to
                                        ;   do in the background routine
        HLT                             ;never executed (hopefully)


CODE            ENDS


DATA    SEGMENT PUBLIC  'DATA'

DATA    ENDS

STACK    SEGMENT STACK 'STACK'
    
    DB 80 DUP ('STACK')
    TopOfStack LABEL WORD

STACK    ENDS

END     START