       NAME  DISPLAY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                    DISPLAY                                  ;
;                                                                           ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Description:      This file stores display routines.
;
; Revision History:
;    02/18/08  Nadine Dabby      initial revision 
;    02/21/08  Nadine Dabby     debugging

; local include files

$INCLUDE(DISPLAY.INC)
$INCLUDE(EH.INC)



CGROUP  GROUP   CODE
DGROUP  GROUP   DATA



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP

EXTRN   Dec2String:NEAR
EXTRN   Hex2String:NEAR
EXTRN   ASCIISegTable:BYTE


;Robotrike Display Routines
;
;Display(str)
;
;Description: 	The function is passed a <null> terminated string (str) to
;output to the 8 digit 7 segment LED display. At most 8 characters can be; 
;displayed at a time. If there are more than 8 digits, the Display will only show the first 8 digits.
;
;Pseudocode:	Call InitDisplay()			;clear display
;Digit = 0
;input = address of first byte of string
;WHILE ([input] != null AND digit != 8 )
;   pattern = Converted[input]
;	Buffer = pattern	        ; Write to Buffer
;	digit = (digit + 1 )		; there are 8 LED digits
;	Buffer = Buffer +1
;   input = input + 1			; move to next char
;ENDWHILE
;WHILE (DIGIT < 7  )
;  	Buffer = blank	        ; Write to Buffer
;	digit = (digit + 1 )		; there are 8 LED digits
;	Buffer = Buffer +1
;   input = input + 1			; move to next char
;ENDWHILE
;
;Arguments: 	The string is passed by reference in ES:SI.
;
;Return Values: 	None
;
;Global Variables: 	DisplayBUFFER
;
;Shared Variables:	DisplayBUFFER
;
;Local Variables:	 digit stores the current display digit, input stores the 
;address of the string as we read through it.
;
;Inputs: 	None
;
;Outputs: 	NONE
;
;Error handling:	Ascii characters that cannot be represented in 7-segment 
;display will be output a blank.
;
;Algorithms:	None
;
;Data Structures:	We use ASCII SegTable from SegTable.asm to hold digit and 
;character LED bit patterns.	
;
;Limitations:	Because we are using 7 segment display not all possible ascii 
;characters can be used (See SegTable.asm for details). Also We can only 
;display at most 8 characters at a time.
;
;Known Bugs: 	None
;
;Special Notes: 	ES is used (as opposed to DS) so the string can be in the 
;code segment (i.e. it can be a constant string) without needing to change DS. 
;
 
Display            PROC    NEAR
                  PUBLIC  Display
        
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DI
        MOV DI, OFFSET(DisplayBuffer) 
        MOV CX, 0                     ;Digit = 0
        MOV  BX, OFFSET(ASCIISegTable) ;and lookup the pattern 
    DisplayLoop:
        CMP CX, 8
        JE EndDisplay
        MOV AL, ES:[SI]
        CMP AL, 0
        JE NullBeforeEight
        XLAT    CS:ASCIISegTable          ;segment override needed because the
        MOV [DI], AL
        INC DI
        INC SI
        INC CX
        JMP DisplayLoop
    NullBeforeEight:
        CMP CX, 7
        JG  EndDisplay
        MOV AL, 0
        XLAT    CS:ASCIISegTable          ;segment override needed because the   
        MOV [DI], AL
        INC DI
        INC CX
        JMP NullBeforeEight
       
    EndDisplay:
        POP DI
        POP CX
        POP BX
        POP AX
        RET   
        
Display        ENDP
	

;
;DisplayNum(n)
;
;Description:	The function is passed a 16-bit signed value (n) to output in 
;decimal (at most 5 digits plus sign) to the LED display. The number (n) is 
;passed in AX by value.  The  Display will always show a sign and will pad 
;the 5 digit output with 0’s. 
;
;	
;Pseudocode:
;               SI = TempBuffer
  ;            	Call Dec2String(n)				; store ASCII at SI
;               Call Display()
;Arguments: 	AX stores passed number, SI will hold the starting address 
;for the string representation of the number	
;
;Return Values:	None. 
;
;Global Variables: 	None.
;
;Shared Variables:	None.
;
;Local Variables:	digit stores the current display digit, input stores the 
;address of the string as we read through it.
;
;Inputs:	None
;
;Outputs:	Numerical outputs to 8 digit   7-segment Display	
;
;Error handling:	None
;
;Algorithms:	Dec2String
;
;Data Structures:	We use Dec2String in hwk3.asm to find the right ASCII 
;output.
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;


DisplayNum            PROC    NEAR
                  PUBLIC  DisplayNum
        PUSH SI
        PUSH ES
        
        MOV SI, OFFSET(TempBuffer)       
        CALL Dec2String				; store ASCII at SI
        PUSH DS
        POP ES
        CALL Display                 
        POP ES
        POP SI
        RET
DisplayNum          ENDP

;DisplayHex(n)
;
;Description:	The function is passed a 16-bit unsigned value (n) to output 
;in hexadecimal (at most 4 digits) to the LED display. The number (n) is 
;passed in AX by value. The  Display will pad the 4 digit output with 0’s. 
;
;Pseudocode: 	SI = TempBuffer
  ;            	Call Hex2String(n)				; store ASCII at SI
;               Call Display()
;
;Arguments: 	AX stores passed number, SI will hold the starting address 
;for the string representation of the number	
;		
;
;Return Values:	None. 
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	digit stores the current display digit, input stores the 
;address of the string as we read through it.
;
;Inputs:	None
;
;Outputs:	Numerical outputs to 8 digit   7-segment Display		
;
;Error handling:	None
;
;Algorithms:	Hex2String	
;
;Data Structures:	We use Dec2String in hwk3.asm to find the right ascii 
;output.
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
DisplayHex            PROC    NEAR
                  PUBLIC  DisplayHex
        PUSH SI
        PUSH ES
        
        MOV SI, OFFSET(TempBuffer)       
        CALL Hex2String				; store ASCII at SI
        PUSH DS
        POP ES
        CALL Display                 
        POP ES
        POP SI
        RET
DisplayHex          ENDP


;MultiplexLED
;
;Description:	This function handles the multiplexing of the LED Display 
;under interrupt conrol. Every 1msec it outputs the next digit (i) 
;on LED Display Digit i.  Also note this function wraps to constantly read another digit. 
;
;Pseudocode:	
;	Digit  =  (Digit + 1) MOD 8	
;    output = displaybuffer(digit) 
;	Return	
;		
;Arguments: 	An ascii character is passed by value in a register
;
;Return Values:	None 
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	c the character to be displayed, and  i the Display digit 
;to be displayed into.
;
;Inputs:	None
;	
;Outputs:	LED Display for Digit i will be c
;
;Error handling:	Ascii characters that cannot be represented in 7-segment 
;display will be output a blank.
;
;Algorithms:	None	
;
;Data Structures:	We use SegTable.asm to store digit and character LED bit 
;patterns.	
;
;Limitations:	Because we are using 7 segment display not all possible ascii 
;characters can be used (See SegTable.asm for details)
;
;Known Bugs: 	None
;
;Special Notes: 	LED pins are active high
;
;
;

MultiplexLED       PROC    NEAR
                  PUBLIC  MultiplexLED

        PUSH AX
        PUSH CX
        PUSH DX
        PUSH SI

        MOV AL, DisplayDigit
        INC AL
        AND AL, 7
        MOV DisplayDigit, AL
        MOV DX, LEDDisplay
        MOV SI, OFFSET(DisplayBuffer)
        ADD DL, AL
        MOV AH, 0
        ADD SI, AX
        MOV AL, [SI]
        OUT DX, AL

        POP SI
        POP DX
        POP CX
        POP AX
        RET
        
MultiplexLED        ENDP




;InitDisplay()
;
;Description:	This function initializes the Multiplexing function for the 
;LED Display. Digit8 – Digit1 correspond to LED outputs reading from left to 
;right (thus the highest order digit is also the leftmost digit).
;
;Pseudocode:	
    ;Digit = 0
    ;WHILE (DIGIT!=8)
;	    Digit = 00000000	;initialize to blank
;       Digit = Digit +1
;	Return
;		
;Arguments: 	None 
;
;Return Values:	None 
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	None (initialize will be output directly to pins)
;
;Inputs:	None
;	
;Outputs:	LED Display will be blank
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	None
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	Pins displaying a-g segments are active high.
;
 ;
InitDisplay       PROC    NEAR
                  PUBLIC  InitDisplay

        PUSH AX
        PUSH BX
        MOV DisplayDigit, 0
        MOV AX, 8
        MOV BX, 0
    InitLEDLoop:
        MOV DisplayBuffer[BX], 00H	;initialize to blank
        INC BX
        CMP AX, BX
        JNE InitLEDLoop
        ;JMP EndInitLED
    EndInitLED:
        POP BX
        POP AX
        RET
        
InitDisplay        ENDP



CODE ENDS





       END    