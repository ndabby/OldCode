;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  SERIAL.INC                                 ;
;                           SERIAL Include File                           ;
;                                                                          ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the serial definitions and should be combined 
; with the other appropriate include files.
;
; Revision History:
;     3/15/08 Nadine Dabby      Initial Version
;
;
;

SERIAL_ERROR_CLEAR      EQU     11110001B
SERIAL_ERROR_READ       EQU     00001110B
SERIAL_BASE_ADDRESS     EQU     00100H
SERIAL_ERROR_ADDRESS    EQU     00105H


NO_SERIAL_ERROR         EQU     00000000B

THRE_ADDRESS            EQU     00101H


DISABLE_THRE            EQU     11111101B
ENABLE_THRE             EQU     00000010B

SERIAL_IIR_ADDRESS      EQU     00102H
SERIAL_IIR_READ         EQU     00000110B

DLAB_ADDRESS            EQU     00103H

LOW_BAUD_DIVISOR_ADDRESS    EQU 00100H
HIGH_BAUD_DIVISOR_ADDRESS   EQU 00101H

SET_DLAB_BIT            EQU     10000000B
CLEAR_DLAB_BIT          EQU     01111111B

LCR_ADDRESS             EQU     00103H

IER_ADDRESS             EQU     00101H

INIT_IER                EQU     00000111B

INIT_LCR                EQU     00011011B

IIR_ADDRESS             EQU     00102H

IIR_READ                EQU     00000110B
