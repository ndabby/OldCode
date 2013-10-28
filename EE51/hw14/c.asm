        NAME  STEP_TABLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                   STEP_TABLE                               ;
;                           Tables of stepper values              ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the stepper motor table
;
; Revision History:
;    03/15/08   Nadine Dabby           initial revision



; local include files
;    none


;setup code group and start the code segment
CGROUP  GROUP   CODE

CODE    SEGMENT PUBLIC 'CODE'


; Step_Table 
;
; Description:      This is the stepper motor table
;
; Notes:            READ ONLY tables should always be in the code segment so
;                   that in a standalone system it will be located in the
;                   ROM with the code.
;
; Author:           Nadine Dabby
; Last Modified:    March 15, 2008

Step_Table       LABEL   Byte
                PUBLIC  Step_Table


;       DB      normalized value (decimal)
			
        DB          00000101B        ;
        DB          00000100B        ; 
        DB          00000110B        ; 
        DB          00000010B        ; 
        DB          00001010B        ; 
        DB          00001000B        ; 
        DB          00001001B        ; 
        DB          00000001B        ; 

 
 ;motor force table


 
 
Force_Table       LABEL   WORD
                PUBLIC  Force_Table
        DW          7FFFH        ; F11
        DW          0000H        ; F12
        DW          0C000H        ; F21
        DW          9127H        ; F22
        DW          0C000H        ; F31
        DW          6ED9H        ;  F32

        
        
CODE    ENDS



        END
