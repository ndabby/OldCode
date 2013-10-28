       NAME  EH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                                                             ;
;                              Event Handler                                ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Description:      This program is a demonstration program to show an
;                   example of an event handler (interrupt service routine).
;                   It just cycles the segments on the target board displays
;                   at the rate of MS_PER_SEG (milliseconds per segment).
;
; Input:            None.
; Output:           The segments on the displays are cycled in a figure eight
;                   pattern (abgedcgfa).  A new segment is output every
;                   interrupt.
;
; User Interface:   None, segments are just cycled.
; Error Handling:   None.
;
; Algorithms:       None.
; Data Structures:  None.
;
; Revision History:
;    11/11/92  Glen George      initial revision (originally ISRDEMO.ASM)
;    10/27/93  Glen George      changed name to EHDEMO
;                               split into two files (.ASM and .INC)
;                               updated comments
;    10/24/94  Glen George      moved call to InitCS so memory is mapped
;                                  BEFORE store values in variables
;                               added complete vector table initialization and
;                                  IllegalEventHandler
;                               changed code segment name from PROG to PROGRAM
;                               updated comments in InitTimer and stack area
;    10/25/95  Glen George      adjusted timer for 18.432 MHz clock instead of
;                                  16 MHz
;                               updated comments
;    10/28/96  Glen George      used COUNTS_PER_MS and MS_PER_SEG in InitTimer
;                                  instead of "magic numbers"
;                               updated comments
;    11/13/96  Glen George      updated comments
;    10/29/97  Glen George      changed all PCB writes to use AL (still writes
;                                  16-bits, see page 4-5 of the
;                                  80C186XL/80C188XL Microprocessor User's
;                                  Manual)
;                               setup to skip IllegalEventHandler writes to
;                                  first RESERVED_VECS vectors
;                               changed name of stack segment
;                               updated comments
;    10/10/98  Glen George      updated comments
;    12/26/99  Glen George      changed segment pattern that is output
;                               updated comments
;    12/25/00  Glen George      send a non-specific EOI in the illegal event
;                                  handler
;                               updated comments
;     1/28/02  Glen George      switched to using ES to install event handlers
;                               updated comments
;     2/06/03  Glen George      changed NO_DIGITS to NUM_DIGITS and added use
;                                  of NUM_IRQ_VECTORS
;                               changed label names for clarity
;                               changed Timer0EOI to TimerEOI
;                               use TimerEOI when setup timer (instead of a
;                                  non-specific EOI)
;                               updated comments
;     1/22/04  Glen George      updated comments
;     2/05/05  Glen George      changed ClrIRQVectors to have a starting and
;                                  ending number for reserved vectors instead
;                                  of assuming they start at vector 0
;     3/15/08  Nadine Dabby     added timer1, timer 2 interrupts


; local include files
$INCLUDE(EH.INC)

EXTRN   MultiplexLED:NEAR
EXTRN   KeyScanDebounce:NEAR
EXTRN   MotorSpeedTimerEH:NEAR
EXTRN   StepperTimerEH:NEAR
EXTRN   SerialEH:NEAR

CGROUP  GROUP   CODE

CODE SEGMENT PUBLIC 'CODE'

        ASSUME  CS:CGROUP
        

; TimerEventHandler
;
; Description:       This procedure is the event handler for the timer
;                    interrupt.  It outputs the next segment pattern to the
;                    LED display.  After going through all the segment
;                    patterns for a digit it goes on to the next digit.  After
;                    doing all the digits it starts over again.
;
; Operation:         Output the segment pattern to the LED then update the
;                    segment pattern index.  If at the end of the segment
;                    patterns, update the LED number.  If at the end of the
;                    LEDs, wrap back to the first one.
;
; Arguments:         None.
; Return Value:      None.
;
; Local Variables:   BX - segment table pointer.
;                    DX - display pointer.
; Shared Variables:  None.
; Global Variables:  Digit  - indicates digit to which to output (updated).
;                    Segmnt - indicates segment pattern to output (updated).
;
; Input:             None.
; Output:            A segment to the display.
;
; Error Handling:    None.
;
; Algorithms:        None.
; Data Structures:   None.
;
; Registers Changed: None
; Stack Depth:       3 words
;
; Author:            Glen George
; Last Modified:     Jan. 27, 2003

TimerEventHandler       PROC    NEAR
                        PUBLIC TimerEventHandler

        PUSH    AX                      ;save the registers
        PUSH    BX                      ;Event Handlers should NEVER change
        PUSH    DX                      ;   any register values

        CALL MultiplexLED
        CALL KeyScanDebounce            ;

EndTimerEventHandler:                   ;done taking care of the timer

        MOV     DX, INTCtrlrEOI         ;send the EOI to the interrupt controller
        MOV     AX, TimerEOI
        OUT     DX, AL

        POP     DX                      ;restore the registers
        POP     BX
        POP     AX


        IRET                            ;and return (Event Handlers end with IRET not RET)


TimerEventHandler       ENDP




; InitCS
;
; Description:       Initialize the Peripheral Chip Selects on the 80188.
;
; Operation:         Write the initial values to the PACS and MPCS registers.
;
; Arguments:         None.
; Return Value:      None.
;
; Local Variables:   None.
; Shared Variables:  None.
; Global Variables:  None.
;
; Input:             None.
; Output:            None.
;
; Error Handling:    None.
;
; Algorithms:        None.
; Data Structures:   None.
;
; Registers Changed: AX, DX
; Stack Depth:       0 words
;
; Author:            Glen George
; Last Modified:     Oct. 29, 1997

InitCS  PROC    NEAR
        PUBLIC InitCS


        MOV     DX, PACSreg     ;setup to write to PACS register
        MOV     AX, PACSval
        OUT     DX, AL          ;write PACSval to PACS (base at 0, 3 wait states)

        MOV     DX, MPCSreg     ;setup to write to MPCS register
        MOV     AX, MPCSval
        OUT     DX, AL          ;write MPCSval to MPCS (I/O space, 3 wait states)


        RET                     ;done so return


InitCS  ENDP




; InitTimer
;
; Description:       Initialize the 80188 Timers.  The timers are initialized
;                    to generate interrupts every MS_PER_SEG milliseconds.
;                    The interrupt controller is also initialized to allow the
;                    timer interrupts.  Timer #2 is used to prescale the
;                    internal clock from 2.304 MHz to 1 KHz.  Timer #0 then
;                    counts MS_PER_SEG timer #2 intervals to generate the
;                    interrupts.
;
; Operation:         The appropriate values are written to the timer control
;                    registers in the PCB.  Also, the timer count registers
;                    are reset to zero.  Finally, the interrupt controller is
;                    setup to accept timer interrupts and any pending
;                    interrupts are cleared by sending a TimerEOI to the
;                    interrupt controller.
;
; Arguments:         None.
; Return Value:      None.
;
; Local Variables:   None.
; Shared Variables:  None.
; Global Variables:  None.
;
; Input:             None.
; Output:            None.
;
; Error Handling:    None.
;
; Algorithms:        None.
; Data Structures:   None.
;
; Registers Changed: AX, DX
; Stack Depth:       0 words
;
; Author:            Glen George
; Last Modified:     Oct. 29, 1997
;         03/15/08   Nadine Dabby initialize timer 1, timer2

InitTimer       PROC    NEAR
                PUBLIC InitTimer

                                ;initialize Timer #2 for Motors
        MOV     DX, Tmr2Count   ;initialize the count register to 0
        XOR     AX, AX
        OUT     DX, AL

        MOV     DX, Tmr2MaxCnt  ;setup max count for 1ms counts
        MOV     AX, TIMER_2_COUNTS_PER_MS
        OUT     DX, AL

        MOV     DX, Tmr2Ctrl    ;setup the control register, no interrupts
        MOV     AX, Tmr2CtrlVal
        OUT     DX, AL

                                ;initialize Timer #0 for Display/Keypad
        MOV     DX, Tmr0Count   ;initialize the count register to 0
        XOR     AX, AX
        OUT     DX, AL

        MOV     DX, Tmr0MaxCntA ;setup max count for milliseconds per segment
        MOV     AX, TIMER_0_COUNTS_PER_MS  ;   count so can time the segments
        OUT     DX, AL

        MOV     DX, Tmr0Ctrl    ;setup the control register, interrupts on
        MOV     AX, Tmr0CtrlVal
        OUT     DX, AL
        
        
                               ;initialize Timer #1 for Stepper interrupts
        MOV     DX, Tmr1Count   ;initialize the count register to 0
        XOR     AX, AX
        OUT     DX, AL

        MOV     DX, Tmr1MaxCntA ;setup max count for milliseconds per segment
        MOV     AX, TIMER_1_COUNTS_PER_MS  ;   count so can time the segments
        OUT     DX, AL

        MOV     DX, Tmr1Ctrl    ;setup the control register, interrupts on
        MOV     AX, Tmr1CtrlVal
        OUT     DX, AL

                                ;initialize interrupt controller for timers
        MOV     DX, INTCtrlrCtrl;setup the interrupt control register
        MOV     AX, INTCtrlrCVal
        OUT     DX, AL

        MOV     DX, INTCtrlrEOI ;send a timer EOI (to clear out controller)
        MOV     AX, TimerEOI
        OUT     DX, AL


        RET                     ;done so return


InitTimer       ENDP




; InstallHandler
;
; Description:       Install the event handler for the timer interrupt.
;
; Operation:         Writes the address of the timer event handler to the
;                    appropriate interrupt vector.
;
; Arguments:         None.
; Return Value:      None.
;
; Local Variables:   None.
; Shared Variables:  None.
; Global Variables:  None.
;
; Input:             None.
; Output:            None.
;
; Error Handling:    None.
;
; Algorithms:        None.
; Data Structures:   None.
;
; Registers Changed: flags, AX, ES
; Stack Depth:       0 words
;
; Author:            Glen George
; Last Modified:     Jan. 28, 2002

InstallHandler  PROC    NEAR
                PUBLIC InstallHandler


        XOR     AX, AX          ;clear ES (interrupt vectors are in segment 0)
        MOV     ES, AX
                                ;store the vector
        MOV     ES: WORD PTR (4 * Tmr0Vec), OFFSET(TimerEventHandler)
        MOV     ES: WORD PTR (4 * Tmr0Vec + 2), SEG(TimerEventHandler)

        MOV     ES: WORD PTR (4 * Tmr1Vec), OFFSET(StepperTimerEH)
        MOV     ES: WORD PTR (4 * Tmr1Vec + 2), SEG(StepperTimerEH)
        
        MOV     ES: WORD PTR (4 * Tmr2Vec), OFFSET(MotorSpeedTimerEH)
        MOV     ES: WORD PTR (4 * Tmr2Vec + 2), SEG(MotorSpeedTimerEH)

        MOV     ES: WORD PTR (4 * INT2Vec), OFFSET(SerialEH)
        MOV     ES: WORD PTR (4 * INT2Vec + 2), SEG(SerialEH)
        
        MOV     DX, INTMASK_REGISTER
        MOV     AX, INTMASK_VALUE
        OUT DX, AX
        
        MOV     DX, INT2CONTROL_REGISTER
        IN      AX, DX
        OR     AX, INT2CONTROL_VALUE
        OUT DX, AX
        
        RET                     ;all done, return


InstallHandler  ENDP




; ClrIRQVectors
;
; Description:      This functions installs the IllegalEventHandler for all
;                   interrupt vectors in the interrupt vector table.  Note
;                   that all 256 vectors are initialized so the code must be
;                   located above 400H.  The initialization skips  (does not
;                   initialize vectors) from vectors FIRST_RESERVED_VEC to
;                   LAST_RESERVED_VEC.
;
; Arguments:        None.
; Return Value:     None.
;
; Local Variables:  CX    - vector counter.
;                   ES:SI - pointer to vector table.
; Shared Variables: None.
; Global Variables: None.
;
; Input:            None.
; Output:           None.
;
; Error Handling:   None.
;
; Algorithms:       None.
; Data Structures:  None.
;
; Registers Used:   flags, AX, CX, SI, ES
; Stack Depth:      1 word
;
; Author:           Glen George
; Last Modified:    Feb. 8, 2002

ClrIRQVectors   PROC    NEAR
                PUBLIC ClrIRQVectors

InitClrVectorLoop:              ;setup to store the same handler 256 times

        XOR     AX, AX          ;clear ES (interrupt vectors are in segment 0)
        MOV     ES, AX
        MOV     SI, 0           ;initialize SI to skip RESERVED_VECS (4 bytes each)

        MOV     CX, 256         ;up to 256 vectors to initialize


ClrVectorLoop:                  ;loop clearing each vector
				;check if should store the vector
	CMP     SI, 4 * FIRST_RESERVED_VEC
	JB	DoStore		;if before start of reserved field - store it
	CMP	SI, 4 * LAST_RESERVED_VEC
	JBE	DoneStore	;if in the reserved vectors - don't store it
	;JA	DoStore		;otherwise past them - so do the store

DoStore:                        ;store the vector
        MOV     ES: WORD PTR [SI], OFFSET(IllegalEventHandler)
        MOV     ES: WORD PTR [SI + 2], SEG(IllegalEventHandler)

DoneStore:			;done storing the vector
        ADD     SI, 4           ;update pointer to next vector

        LOOP    ClrVectorLoop   ;loop until have cleared all vectors
        ;JMP    EndClrIRQVectors;and all done


EndClrIRQVectors:               ;all done, return
        RET


ClrIRQVectors   ENDP




; IllegalEventHandler
;
; Description:       This procedure is the event handler for illegal
;                    (uninitialized) interrupts.  It does nothing - it just
;                    returns after sending a non-specific EOI.
;
; Operation:         Send a non-specific EOI and return.
;
; Arguments:         None.
; Return Value:      None.
;
; Local Variables:   None.
; Shared Variables:  None.
; Global Variables:  None.
;
; Input:             None.
; Output:            None.
;
; Error Handling:    None.
;
; Algorithms:        None.
; Data Structures:   None.
;
; Registers Changed: None
; Stack Depth:       2 words
;
; Author:            Glen George
; Last Modified:     Dec. 25, 2000

IllegalEventHandler     PROC    NEAR

        NOP                             ;do nothing (can set breakpoint here)

        PUSH    AX                      ;save the registers
        PUSH    DX

        MOV     DX, INTCtrlrEOI         ;send a non-sepecific EOI to the
        MOV     AX, NonSpecEOI          ;   interrupt controller to clear out
        OUT     DX, AL                  ;   the interrupt that got us here

        POP     DX                      ;restore the registers
        POP     AX

        IRET                            ;and return


IllegalEventHandler     ENDP



CODE ENDS



       END    
