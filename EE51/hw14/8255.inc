;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  8255.INC                                 ;
;                                   motor port                       ;
;                                 Include File                               ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the motor port definitions.
;
; Revision History:
;     3/15/08 Nadine Dabby      Initial Version

;Parameters for 8255

BASE_8255 EQU 180H ;base address for 8255
PORT_A EQU (BASE_8255 + 0) 
PORT_B EQU (BASE_8255 + 1)
PORT_C EQU (BASE_8255 + 2)

CONTROL_WORD_8255 EQU 10000000B ; need to output to controll address
CONTROL_ADDRESS_8255 EQU (BASE_8255 +3)  ;control address of 8255



