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

;external functions

EXTRN   Dec2String:NEAR
EXTRN   Hex2String:NEAR
EXTRN   ASCIISegTable:BYTE


;Robotrike Display Routines
;
;Display(str)
;
;Description: 	The function is passed a <null> terminated string (str) to
;output to the 8 digit 7 segment LED display. At most 8 characters can be; 
;displayed at a time. If there are more than 8 digits, the Display will only 
;show the first 8 digits.
;
;Pseudocode:	
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
;Arguments: 	The string is passed by reference in ES:SI. We store the Display 
;Buffer in DI
;
;Return Values: 	None
;
;Global Variables: 	TempBuffer, DisplayBUFFER
;
;Shared Variables:	TempBuffer, DisplayBUFFER
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
;code segment (i.e. it can be a constant string) without needing to change DS. Also 
;We can pass a string directly in SI without using the temporary buffer.
 
Display            PROC    NEAR
                  PUBLIC  Display
        
        PUSH AX				;store registers that we are using
        PUSH BX
        PUSH CX
        PUSH DI
        MOV DI, OFFSET(DisplayBuffer) 	;location of string to be displayed
        MOV CX, 0                     ;Digit = 0
        MOV  BX, OFFSET(ASCIISegTable) ;location of lookup the pattern 

    DisplayLoop:
        CMP CX, 8			;if Digit = 8 we are done
        JE EndDisplay
        MOV AL, ES:[SI]			;move ASCII char from string into AL
        CMP AL, 0			; compare with NULL
        JE NullBeforeEight		; IF Null jump to NullBeforeEight loop
        XLAT    CS:ASCIISegTable          ;look up pattern in segtable
        MOV [DI], AL			;move character pattern into AL
        INC DI				; move over to next Char in Display Buffer
        INC SI				; move over to next Char in String
        INC CX				;increment digit count
        JMP DisplayLoop			;loop

    NullBeforeEight:			;Loop to Deal with short String
        CMP CX, 7			; if Digit>7 we are done
        JG  EndDisplay	
        MOV AL, 0			;Move Null symbol into AL
        XLAT    CS:ASCIISegTable          ;look up bitpattern for NULL   
        MOV [DI], AL			;store pattern in Display buffer
        INC DI				; move over to next Char in Display Buffer
        INC CX				;increment digit count
        JMP NullBeforeEight
       
    EndDisplay:				;Restore registers
        POP DI
        POP CX
        POP BX
        POP AX
        RET   				;Return
        
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
        PUSH SI					;store registers
        PUSH ES
        
        MOV SI, OFFSET(TempBuffer)       	;put address of Temp Buffer into SI
        CALL Dec2String				; store ASCII at SI
        PUSH DS					;
        POP ES					;set ES to DS
        CALL Display                 		;Call Display function
        POP ES					;restore registers
        POP SI
        RET					;return
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
        PUSH SI					;store
        PUSH ES
        
        MOV SI, OFFSET(TempBuffer)       	;put address of Temp Buffer into SI
        CALL Hex2String				; store ASCII at SI
        PUSH DS
        POP ES					;set ES to DS
        CALL Display                 		;Call Display function
        POP ES
        POP SI					;restore registers
        RET					;return
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

        PUSH AX					;store registers
        PUSH CX
        PUSH DX
        PUSH SI

        MOV AL, DisplayDigit			;store Digit to update in AL
        INC AL					;increment digit
        AND AL, 7				;digit = (digit) mod (7)
        MOV DisplayDigit, AL			;save new value of digit to Display Digit
        MOV DX, LEDDisplay			;set DX to address of Display
        MOV SI, OFFSET(DisplayBuffer)		;set SI to address of DisplayBuffer
        ADD DL, AL				;Add offset of Digit to display address
        MOV AH, 0				;zero out higher bits of AX
        ADD SI, AX				;add offset of digit to buffer address
        MOV AL, [SI]				;put buffer char pattern into AL 
        OUT DX, AL				;output pattern into DisplayDigit

        POP SI					;restore registers
        POP DX
        POP CX
        POP AX
        RET					;return
        
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

        PUSH AX				;store registers
        PUSH BX
        MOV DisplayDigit, 0
        MOV AX, 8
        MOV BX, 0
    InitLEDLoop:			;for (char = 0 to 7)
        MOV DisplayBuffer[BX], 00H	;initialize pattern to blank
        INC BX				;increment char
        CMP AX, BX			;
        JNE InitLEDLoop
        ;JMP EndInitLED
    EndInitLED:
        POP BX				;restore registers
        POP AX
        RET
        
InitDisplay        ENDP



CODE ENDS

DATA    SEGMENT PUBLIC  'DATA'
;

DATA    ENDS

;the stack

STACK           SEGMENT STACK  'STACK'

                DB      80 DUP ('Stack ')       ;240 words

TopOfStack      LABEL   WORD

STACK           ENDS


       END    