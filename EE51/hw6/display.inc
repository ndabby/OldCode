;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  DISPLAY.INC                                 ;
;                           Display Include File                           ;
;                                                                          ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the Display struct definitions and should be combined 
; with the other appropriate include files.
;
; Revision History:
;     2/17/08 Nadine Dabby      Initial Version

;Parameters for Display

DISPLAY_SIZE  EQU   8              ;Max Size of display buffer


DATA    SEGMENT PUBLIC  'DATA'

TempBuffer           DB       DISPLAY_SIZE DUP (?) 
DisplayBuffer        DB       DISPLAY_SIZE DUP (?) 
DisplayDigit         DB         ?               ;the current digit number

DATA    ENDS
