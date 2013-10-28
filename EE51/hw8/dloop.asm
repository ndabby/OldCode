NAME DISPLAYLOOP
;
;Main Loop to test Display
;Revision History
;   2/17/08 Nadine Dabby    Written and Debugged
;
;

$INCLUDE(DISPLAY.INC)


CGROUP  GROUP   CODE
DGROUP  GROUP   DATA, STACK



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP, SS:DGROUP



;external function declarations

EXTRN GetKeyTest:NEAR
EXTRN InitDisplay:NEAR
EXTRN KeyInit:NEAR               
EXTRN InitCS:NEAR
EXTRN ClrIRQVectors:NEAR
EXTRN InstallHandler:NEAR
EXTRN InitTimer:NEAR


START: 
MAIN:
        CLI
        MOV     AX, DGROUP               ;initialize the stack pointer
        MOV     SS, AX
        MOV     SP, OFFSET(TopOfStack)

        MOV     AX, DGROUP                ;initialize the data segment
        MOV     DS, AX


        CALL    InitCS                  ;initialize the 80188 chip selects
                                        ;   assumes LCS and UCS already setup

        CALL    ClrIRQVectors           ;clear (initialize) interrupt vector table

                                        ;initialize the variables for the timer event handler
 ;       MOV     Digit, 0                ;start on digit 0
        
        CALL    InstallHandler          ;install the event handler
                                        ;   ALWAYS install handlers before
                                        ;   allowing the hardware to interrupt.

        CALL    InitTimer               ;initialize the internal timer
        CALL    InitDisplay
        CALL    KeyInit
        STI                             ;and finally allow interrupts.


        CALL    GetKeyTest
        
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