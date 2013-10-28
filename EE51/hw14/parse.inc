;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                   PARSE.INC                                  ;
;                   Driver for Parsing Command Strings                ;
;                                 Include File                               ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the assembly language definitions for the command
; parser.  Mainly these are the state and token type definitions.
;
; Revision History:
;     03/18/08  Nadine Dabby             initial version



; State definitions
;    note that these MUST match the layout of the transition table

ST_INITIAL	EQU	0		;initial state
ST_S1	    EQU	1		;state S1 --in speed command
ST_S1_PLUS  EQU	2		;state
ST_S_DIGIT  EQU	3		;state

ST_V1	    EQU	4		;state V1 -- in rel. speed command
ST_V1_PLUS  EQU	5		;state V1 -- in rel. speed command 
ST_V1_MINUS EQU	6		;state V1 -- in rel. speed command
ST_V_POS_DIGIT  EQU	7		;state V1 -- in rel. speed command
ST_V_NEG_DIGIT  EQU	8		;state V1 -- in rel. speed command

ST_D1	    EQU	9		;state D1 --in direction command
ST_D1_PLUS  EQU	10		;state 
ST_D1_MINUS EQU	11		;state 
ST_D_POS_DIGIT  EQU	12		;state 
ST_D_NEG_DIGIT  EQU	13		;state  -- 

ST_T1	    EQU	14		;state T1 --in Turret command
ST_T_PLUS   EQU 15          ;
ST_T_MINUS  EQU 16          ;
ST_T_NOSIGN_DIGIT   EQU 17  ;
ST_T_POS_DIGIT  EQU	18		;state 
ST_T_NEG_DIGIT  EQU	19		;state 

NUM_STATES	EQU	20		;number of states



; Token Type Definitions
;    note that these MUST match the layout of the transition table

TOKEN_DIGIT	EQU	0		;token is a digit: 0 to 9
TOKEN_PLUS	EQU	1		;token is a + 
TOKEN_MINUS	EQU	2		;token is a - 
TOKEN_S 	EQU	3		;token is a S
TOKEN_V 	EQU	4		;token is a V
TOKEN_D 	EQU	5		;token is a D
TOKEN_T 	EQU	6		;token is a T
TOKEN_F 	EQU	7		;token is a F
TOKEN_O 	EQU	8		;token is a O
TOKEN_EOS	EQU	9		;token is end of string: <null>
TOKEN_OTHER	EQU	10		;anything else

NUM_TOKEN_TYPES	EQU	11		;number of token types



; Other Constants

