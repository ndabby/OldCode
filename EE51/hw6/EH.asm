       NAME  EH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                                                             ;
;                              Event Handler                                ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Description:      This program has routines for event handlers 
;		    (interrupt service routine).
;                   It just calls my multiplex LED function (in display.asm)
;                   at the rate of MS_PER_SEG (milliseconds per segment).
;
; Input:            None.
; Output:           None.
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
;     2/22/08 Nadine Dabby	updated code to work with routines in display.asm
;     3/2/08  Nadine Dabby	revised to include keypad routines


; local include files
$INCLUDE(EH.INC)

;external function declarations
EXTRN   MultiplexLED:NEAR
EXTRN	KeyScanDebounce:NEAR

CGROUP  GROUP   CODE
DGROUP  GROUP   DATA, STACK

CODE SEGMENT PUBLIC 'CODE'

        ASSUME  CS:CGROUP, DS:DGROUP, SS:DGROUP


; TimerEventHandler
;
; Description:       This procedure is the event handler for the timer
;                    interrupt.  It calls the function to update the next LED digit.
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
; Stack Depth:       3 words
;
; Author:            Glen George
; Last Modified:     Feb 22, 2008 (by Nadine Dabby--changed display call)

TimerEventHandler       PROC    NEAR

        PUSH    AX                      ;save the registers
        PUSH    BX                      ;Event Handlers should NEVER change
        PUSH    DX                      ;   any register values

        CALL MultiplexLED		   ;update the display
	CALL KeyScanDebounce		;debounce keys


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
; Last Modified:     Feb. 22, 2008 (Nadine Dabby --commented out timer2)

InitTimer       PROC    NEAR
                PUBLIC InitTimer

                                ;initialize Timer #2 as a prescalar
      ;  MOV     DX, Tmr2Count   ;initialize the count register to 0
       ; XOR     AX, AX
      ;  OUT     DX, AL

      ;  MOV     DX, Tmr2MaxCnt  ;setup max count for 1ms counts
      ;  MOV     AX, COUNTS_PER_MS
      ;  OUT     DX, AL

      ;  MOV     DX, Tmr2Ctrl    ;setup the control register, no interrupts
      ;  MOV     AX, Tmr2CtrlVal
      ;  OUT     DX, AL

                                ;initialize Timer #0 for MS_PER_SEG ms interrupts
        MOV     DX, Tmr0Count   ;initialize the count register to 0
        XOR     AX, AX
        OUT     DX, AL

        MOV     DX, Tmr0MaxCntA ;setup max count for milliseconds per segment
        MOV     AX, COUNTS_PER_MS  ;   count so can time the segments
        OUT     DX, AL

        MOV     DX, Tmr0Ctrl    ;setup the control register, interrupts on
        MOV     AX, Tmr0CtrlVal
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




; SegPatTable
;
; Description:      This is the segment pattern table.  It contains all the
;                   patterns to be output to the display.
;
; Notes:            READ ONLY tables should always be in the code segment so
;                   that in a standalone system they will be located in the
;                   ROM with the code.
;
; Author:           Glen George
; Last Modified:    Dec. 26, 1999


CODE ENDS



;the data segment

DATA    SEGMENT PUBLIC  'DATA'

DATA    ENDS


;the stack

STACK           SEGMENT STACK  'STACK'

                DB      80 DUP ('Stack ')       ;240 words

TopOfStack      LABEL   WORD

STACK           ENDS



       END    
