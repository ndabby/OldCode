;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  QUEUE.INC                                 ;
;                           Microprocessor-Based Queue                       ;
;                                 Include File                               ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the Queue struct definitions and should be combined 
; with the other appropriate include files.
;
; Revision History:
;     2/17/08 Nadine Dabby      Initial Version

;Parameters for Queue

QUEUE_SIZE  EQU   255              ;Max Size of Queue

;Structure for Queue

QUEUE         STRUC                     ;structure containing a queue's informaiton
		Head    DW    ?
		Tail    DW    ?
		QueueSize    DW    ?		
        Array  	DB    QUEUE_SIZE DUP (?) 
QUEUE         ENDS