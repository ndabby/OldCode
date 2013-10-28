        NAME    HW3PR1
        
;Nadine Dabby
;EE 51
;January 30, 2008
;
;Homework 2 (2.5 days late)
;
;1.     Dec2String
;
;Description:  	The function is passed a 16-bit signed
; value (n) that it 
;		will convert to decimal (at most 5 digits plus sign) and 
;		store as a string starting at the memory location indicated 
;		by the passed address (a). 
; 
;Arguments:        AX - decimal value to convert to string.
;		  SI - address at which to store string
;
;Return Values:    CF - set to 1 if passed value > 9999 (decimal),
;                       0 otherwise.
;                  
;Local Variables:
;  arga (SI)  - copy of address.
;                  argn (AX)  - decimal
; digit.
;		  index (BX) - stores index into address.
;		  number (DI) - stores number being computed.
;                 digit (DX)  - computed decimal digit.
;                  error (CF)  - error flag.
;                  pwr10 (CX)  - current power of 10 being computed.
;
;
;Error
;Handling:	If number is over 5 digits, error flag will be set;
;		
;Algorithms: 	TwosComplement
;
;Data 
;Structures:	number will be placed in address specified by DS:SI
;
;Known Bugs: 	none
;
;Limitations:	Will not compute a number > 99999
;
;
;Pseudo Code
;  
;  index = 0
;  
;  IF (1st bit of argn = 1)
;	  DS:SI[index] = '000101101'              ; negative sign
;	  number = TwosComplement(argn);
;	  index = index + 8
;	
;  ELSE    DS:SI[index] = '000101011' 		;positive sign
;	  number = argn;
;          index = index + 8
;  ENDIF
;
;  pwr10 = 10000
;  error = FALSE
;  WHILE ((error = FALSE) AND (pwr10 >
; 0))
;      digit = number/pwr10
;      IF (digit = 0) THEN
;	  DS:SI[index] = '000100000'                  ;space
;	  index = index + 8
; 	  pwr10 = pwr10/10
;          error = FALSE
;
;      ELSE IF (digit < 10) THEN
;          DS:SI[index] = 'digit +
; 000110000'          ; digit + 60
;          index = index + 8
;          number = number MODULO pwr10
;          pwr10 = pwr10/10
;    
;      error = FALSE
;      ELSE
;          error = TRUE
;	  DS:SI[index] = '000000000'
;      ENDIF
;  ENDWHILE
;  RETURN  error
;
;TwosComplement
;
;Description: 	The function is passed a 16-bit value (n) that it 
;		will convert to the twos complement bit value which it 
;		will return. 
; 
;Arguments:        n - binary number to convert.
;		 
;Return Values:    number - twos complement bit string.
;            
;      
;Local Variables:  number  - binary string.
;
;Function TwosComplement(n)
;	number = Not(n)
;	number = number + 1
;	return number 
;End Function
;
;
CGROUP  GROUP   CODE
DGROUP  GROUP   DATA

CODE    SEGMENT PUBLIC 'CODE'

        ASSUME  CS:CGROUP, DS:DGROUP
    
Dec2String      PROC    NEAR
                PUBLIC  Dec2String

Dec2StringInit:                         ;initialization
        PUSHA
        MOV     BX, 0                   ;index is 0 to start with
        MOV     CX, 10000               ;start with 10^4 (10000's digit)
        ;CLC                             ;no error yet
        MOV     DI, AX                  ; otherwise move AX to DI
                                        ;
        CMP     DI, 0                   ; test if DI is negative
        JL      Negative                ; if negative move to Negative label

        MOV     AL, '+'
        MOV     DS:[SI + BX], AL          ; put + sign in first byte
        INC     BX                       ; increment index
        JMP     Dec2StringLoop            ;now start looping to get digits

Negative:
        ;MOV     AL, '-'
        MOV     byte ptr DS:[SI + BX], '-'          ; put negative sign in first byte
        INC     BX                      ; increment index
        NEG     DI                      ; put two's complement of DI
       ;JMP    Dec2StringLoop            ;now start looping to get string

Dec2StringLoop:                            ;loop getting the digits in DX

        ;JC      EndDec2StringLoop          ;if there is an error - we're done
        CMP     CX, 0                     ;check if pwr10 > 0
        JLE     EndDec2StringLoop          ;if not, have done all digits, done
        ;JMP    Dec2StringLoopBody         ;else get the next digit

Dec2StringLoopBody:                        ;get a digit
        MOV     DX, 0                   ;setup for arg/pwr10
        MOV     AX, DI
        DIV     CX                      ;digit (AX) = arg/pwr10
        ;CMP     AX, 10                  ;check if digit < 10
        ;JAE     TooBigError             ;if not, it's an error
        ;JB     HaveDigit               ;otherwise process the digit

HaveDigit:                              ;put the digit into the result
        ;CMP     AX, 0                   ; check if digit = 0
        ;JE      Space                   ; no digit just space
        ADD     AX, '0'
        MOV     DS:[SI + BX], AL
        INC     BX
        MOV     DI, DX                  ;now work with arg = arg MODULO pwr10
        MOV     DX, 0
        MOV     AX, CX                  ;setup to update pwr10
        MOV     CX, 10                  ;   (clears CH too)
        DIV     CX                      ;   
        MOV     CX, AX                  ;pwr10 = pwr10/10 
        ;CLC                             ;no error
        JMP     EndDec2StringLoopBody      ;done getting this digit
Space: 
  ;      MOV     AL, ' '
   ;     MOV     DS:[SI + BX], AL          ; move space into string
    ;    INC     BX                      ; increment index
     ;   MOV     DI, DX                  ;now work with arg = arg MODULO pwr10
      ;  MOV     DX, 0
  ;      MOV     AX, CX                  ;setup to update pwr10
   ;     MOV     CX, 10                  ;   (clears CH too)
    ;    DIV     CX                      ;   
     ;   MOV     CX, AX                  ;pwr10 = pwr10/10 
        ;CLC                             ;no error
        JMP     EndDec2StringLoopBody    ;done getting this digit
TooBigError:                            ;the value was too big
        STC                             ;set the error flag
        ;JMP    EndDec2StringLoopBody      ;and done with this loop iteration

EndDec2StringLoopBody:
        JMP     Dec2StringLoop             ;keep looping (end check is at top)


EndDec2StringLoop:                         ;done converting
        ;MOV     AX, 0
        MOV     byte ptr DS:[SI + BX], 00H            ; null termination
        POPA
        RET                             ;and return

Dec2String         ENDP


;-------------------------------------------------------------------------
;
;Hex2string
;
;Description:	The function is passed a 16-bit unsigned
; value (n) that it 
;		will convert to hexadecimal (at most 4 digits) and store as 
;		a string starting at the memory location indicated by the 
;		passed address (a).   	
;
;Arguments:        AX - hexadecimal value to convert to string.
;		  SI - address at which to store string
;
;Return Values:    CF - set to 1 if passed value > 9999 (decimal),
;                       0 otherwise.
;                 
;Local Variables:
; arga (SI)  - copy of address.
;                  argn (AX)  - binary
; unsigned digit.
;		  index (BX) - stores index into address.
;                  digit (AX)  - computed hexadecimal character.
;                  pwr16 (CX)  - current power of 16 being computed.
;		  error (CF)  - error flag.
;
;
;
;Error
;Handling:	none
;		
;Algorithms: 	none
;
;Data 
;Structures:	number will be placed in address specified by DS:SI
;
;Known Bugs: 	none
;
;Limitations:	none
;
;Pseudo Code
; 
;  index = 0
;  number = argn
;  pwr16 = 32768
;  error = FALSE
;  WHILE ((error = FALSE) AND (pwr16 >
; 0))
;      digit = number/pwr16
;      IF (digit < 10) THEN
;          DS:SI[index] = 'digit + 000110000'
;           digit + 60
;          index = index + 8
;          number = number MODULO pwr16
;          pwr16 = pwr16/16
;    
;      error = FALSE
;      ELSE IF (digit < 16) THEN
;	  digit = digit - 9
;          DS:SI[index] = 'digit + 001000000'      
;     digit - 9 + 64
;          index = index + 8
;          number = number MODULO pwr16
;          pwr16 = pwr16/16
;    
;      error = FALSE
;      ELSE
;          error = TRUE
;	  DS:SI[index] = '000000000'
;      ENDIF
;  ENDWHILE
;  RETURN  error


Hex2String      PROC    NEAR
                PUBLIC  Hex2String

Hex2StringInit:                         ;initialization
        PUSHA
        MOV     BX, 0                   ;index is 0 to start with
        MOV     CX, 4096               ;start with 4096 
        CLC                             ;no error yet
        MOV     DI, AX                  ; otherwise move AX to DI
        JMP     Hex2StringLoop            ;now start looping to get digits


Hex2StringLoop:                            ;loop getting the digits in DX

        ;JC      EndHex2StringLoop          ;if there is an error - we're done
        CMP     CX, 0                     ;check if pwr16 > 0
        JLE     EndHex2StringLoop          ;if not, have done all digits, done
        ;JMP    Hex2StringLoopBody         ;else get the next digit

Hex2StringLoopBody:                      ;get a digit
        MOV     DX, 0                   ;setup for arg/pwr10
        MOV     AX, DI
        DIV     CX                      ;digit (AX) = arg/pwr10
        CMP     AX, 10                  ;check if digit < 10
        JAE     Alpha             ;if not, it's an alpha char
        ;JB     HexDigit               ;otherwise process the digit

HexDigit:                              ;put the digit into the result
        ADD     AX, '0'
        MOV     DS:[SI + BX], AL
        INC     BX
        MOV     DI, DX                  ;now work with arg = arg MODULO pwr16
        MOV     DX, 0
        MOV     AX, CX                  ;setup to update pwr10
        MOV     CX, 16                  ;   (clears CH too)
        DIV     CX                      ;   
        MOV     CX, AX                  ;pwr16 = pwr16/16 
        CLC                             ;no error
        JMP     EndHex2StringLoopBody      ;done getting this digit
Alpha: 
        ADD     AX, 'A'
        SUB     AX, 10
        MOV     DS:[SI + BX], AL
        INC     BX
        MOV     DI, DX                  ;now work with arg = arg MODULO pwr16
        MOV     DX, 0
        MOV     AX, CX                  ;setup to update pwr10
        MOV     CX, 16                  ;   (clears CH too)
        DIV     CX                      ;   
        MOV     CX, AX                  ;pwr16 = pwr16/16 
        CLC                             ;no error
        JMP     EndHex2StringLoopBody      ;done getting this digit


EndHex2StringLoopBody:
        JMP     Hex2StringLoop             ;keep looping (end check is at top)


EndHex2StringLoop:                         ;done converting
        Mov     AX, 0
        MOV     DS:[SI + BX], AL            ; null termination
        POPA
        RET                             ;and return

Hex2String         ENDP  

CODE    ENDS


DATA    SEGMENT PUBLIC  'DATA'

	; data goes here

DATA    ENDS
        END