;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  KEYPAD.INC                                 ;
;                           KEYPAD Include File                           ;
;                                                                          ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the keypad struct definitions and should be combined 
; with the other appropriate include files.
;
; Revision History:
;     2/28/08 Nadine Dabby      Initial Version

;Parameters for KEYPAD

DEBOUNCE_TIME EQU 10              ;number of timer counts per 10 ms 
                                    ;(assumes 18.432 MHz clock)
AUTO_REPEAT EQU 500
                                    
KEYSCAN_MASK EQU 00001111B           ;bit mask for keypad

