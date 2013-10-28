        NAME  KEYTABLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                   KEYTABLE                                 ;
;                           Tables of KEY Codes                        ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; local include files
;    none




;setup code group and start the code segment
CGROUP  GROUP   CODE

CODE    SEGMENT PUBLIC 'CODE'


; KeyTable
;
; Description:      This is the key code table. IF more than one key is 
;pressed nothing happens.
;
; Notes:            READ ONLY tables should always be in the code segment so
;                   that in a standalone system it will be located in the
;                   ROM with the code.
;
; Author:           NAdine DABBY
; Last Modified:    2-29-08

KeyTable   LABEL   BYTE
                PUBLIC  KeyTable

        DB      00000000B               ;0
        DB      00000001B               ;1
        DB      00000010B               ;2
        DB      00000000B               ;3
        DB      00000011B               ;4
        DB      00000000B               ;5
        DB      00000000B               ;6
        DB      00000000B               ;7
        DB      00000100B               ;8
        DB      00000000B               ;9
        DB      00000000B               ;A
        DB      00000000B               ;B
        DB      00000000B               ;C
        DB      00000000B               ;D
        DB      00000000B               ;E
        DB      00000000B               ;F

CODE    ENDS



        END
