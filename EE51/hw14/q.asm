       NAME  QUEUE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                    QUEUE                                  ;
;                                                                           ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Description:      This file stores queue routines.
;
; Revision History:
;    02/11/08  Nadine Dabby      initial revision 
;    02/17/08  Nadine Dabby     debugging

; local include files

$INCLUDE(QUEUE.INC)


CGROUP  GROUP   CODE
DGROUP  GROUP   DATA, STACK



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP



;
;QueueInit(a, s)
;
;Description: 	Initialize the queue of the passed size (s) at the passed 
;address (a). This procedure does all the necessary initialization to prepare
;the queue for use. After calling this procedure the queue should be empty 
;and ready to accept values. The passed size (s) is the maximum number of 
;items that can be stored in the queue. 
;
;Pseudocode:
;	Declare Struct:
;		Size = s
;		Head = 0
;		Tail = 0
;	End Struct
;
;Arguments: 	The address (a) is passed in SI by value (thus the queue 
;starts at DS:SI) and the size (s) is passed by value in AX.
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables: None
;
;Local Variables:	Size, Head, Tail 
;
;Inputs: 		None
;
;Outputs: 		None
;
;Error handling:	None
;
;Algorithms:		None
;
;Data Structures:	We will have a Queue Struct which holds the size s of the 
;queue and will keep pointers to the head (front) and tail (end) of the queue.
;
;Limitations:		The Queue can only hold a fixed number of quanitities 
;(s = size).
;
;Known Bugs: 		None
;
;Special Notes: 	None
;


QueueInit       PROC    NEAR
                PUBLIC  QueueInit
            PUSH AX                 ;store registers used
            INC AX                  ;account for offset in size
            MOV [SI].QueueSize, AX  ;Set Size of array
            MOV [SI].Head, 0        ;Set head offset to 0 
            MOV [SI].Tail, 0        ;Set tail offset to 0
            POP AX                  ;restore registers
            RET

QueueInit          ENDP


;
;QueueEmpty(a)
;
;Description:		The function is called with the address of the queue to 
;be checked (a) and returns with the zero flag set if the queue is empty and 
;with the zero flag reset otherwise. 
;
;Pseudocode:
;		IF (head = tail)
;			Set Zero Flag to 1
;		ELSE
;			Clear Zero Flag
;		RETURN
;
;Arguments: 		The address (a) is passed in SI by value (thus the queue 
;starts at DS:SI).
;
;Return Values:	None. (Output is stored in Zero Flag).
;
;Global Variables: 	None.
;
;Shared Variables: None 
;
;Local Variables:	Head, Tail
;
;Inputs:			None
;
;Outputs:		Zero Flag is set to 1 if Queue is empty and to 0 if not empty.
;
;Error handling:	None
;
;Algorithms:		Check if tail and Head pointer are pointing to the same 
;place. If so, then the Queue is empty, if not, then the queue contains at 
;least one item.
;
;Data Structures:	We will have a Queue Struct which holds the size s of the 
;queue and will keep pointers to the head (front) and tail (end) of the queue.
;
;Limitations:		None
;
;Known Bugs: 		None
;
;Special Notes: 	None
;
;

QueueEmpty       PROC    NEAR
                PUBLIC  QueueEmpty

            PUSH AX                     ;Store Registers
            PUSH BX
            MOV AX, [SI].Head
            MOV BX, [SI].Tail           ;		IF (head = tail)
            CMP AX, BX                  ;			Set Zero Flag to 1
            POP BX                            ;		ELSE Clear Zero Flag
            POP AX                            ;	Restore Registers		
            RET                         ;		RETURN   

QueueEmpty          ENDP


;QueueFull(a)
;
;Description:		The function is called with the address of the queue to 
;be checked (a) and returns with the zero flag set if the queue is full and 
;with the zero flag reset otherwise. 
;
;Pseudocode:
;		IF (Head = (Tail +1))
;			Set Zero Flag to 1
;		ELSE IF ((Tail = StartAddress + Size -1 ) &(Head = StartAddress))
;			Set Zero Flag to 1
;		ELSE 
;			Clear Zero Flag
;		RETURN
;
;
;Arguments: 		The address (a) is passed in SI by value (thus the queue 
;starts at DS:SI).
;
;Return Values:	None. (Output is stored in Zero Flag).
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	Head, Tail, StartAddress and Size.
;
;Inputs:			None
;	
;Outputs:		Zero Flag is set to 1 if Queue is full and to 0 if not full.
;
;Error handling:	Make Sure Queue does not go out of bounds. As Queue fills 
;and empties, move pointers back to start location to contain memory.
;
;Algorithms:		We check if  head = Tail + 1 (This indicates that the 
;queue is full).  Because we are reusing memory and do not want to go out of 
;bounds of our allocated space we need to also account for the StartAddress 
;thus we also check if  (tail  = size + StartAddress -1) & (StartAddress = head).
;
;Data Structures:	We will have a Queue Struct which holds the size s of the 
;queue and will keep pointers to the head (front) and tail (end) of the queue.
;
;Limitations:		None
;
;Known Bugs: 		None
;
;Special Notes: 	None
;
;
QueueFull       PROC    NEAR
                PUBLIC  QueueFull


                PUSH AX                 ;Store Registers
                PUSH BX
                PUSH CX
                MOV AX, [SI].Head      ;		
                MOV BX, [SI].Tail           
                INC BX                  ;IF (Head = (Tail +1))
                CMP AX, BX              ;	Set Zero Flag to 1	
                JE  EndQueueFull
                ;JMP QueueFullCheckTail 

    QueueFullCheckTail: 
                MOV BX, [SI].Tail       ;ELSE IF 

                MOV CX, [SI].QueueSize
                DEC CX
                CMP BX, CX
                JE QueueFullCheckHead   ;(Tail = StartAddress + Size -1 )
                JNE EndQueueFull
                
    QueueFullCheckHead: 
                CMP AX, 0               ; AND ( &(Head = StartAddress))
                ;JMP EndQueueFull       ;			Set Zero Flag to 1
    
                              
    EndQueueFull:     
                POP CX                      ;Restore Registers
                POP BX                         
                POP AX                        
                RET                         ;		RETURN   



QueueFull          ENDP




;Dequeue(a)
;
;Description: 		This function removes an 8-bit value from the head of the 
;queue at the passed address (a) and returns it in AL. If the queue is empty 
;it waits until the queue has a value to be removed and returned. It does not 
;return until a value is taken from the queue. (This is called a "blocking 
;function".) 
;
;pseudocode:
;		REPEAT
;			QueueEmpty(a)
;		UNTIL ( ZeroFlag = 0)
;		AL = item stored in address Head
;		Head = Head + 1
;       Head = Head/Size
;		RETURN
;
;
;Arguments:		The address (a) is passed in SI by value (thus the queue 
;starts at DS:SI).
;
;Return Values:	The 8-bit value that has been popped is returned in AL.
;
;Global Variables: 	None
;
;Shared Variables:	None.
;
;Local Variables:	Head, Tail, StartAddress and Size
;
;Inputs:			None
;
;Outputs:		None
;
;Error handling:	None
;
;Algorithms:		Wait until there is an item in Queue. Then store that item 
;in AL and increment head pointer. Ensure that we do not exceed queue memory 
;allocation by checking that head pointer will not go past (StartAddress + 
;Size - 1).
;
;Data Structures:	We will have a Queue Struct which holds the size s of the 
;queue and will keep pointers to the head (front) and tail (end) of the queue.
;
;Limitations:		Will not return until there is something in the Queue to 
;remove.
;
;Known Bugs: 		None
;
;Special Notes: 	This is a blocking function: It does not return until a 
;value is taken from the queue.
;
;


Dequeue       PROC    NEAR
                PUBLIC  Dequeue

                                    ;if calling this function assume SI = array
    WaitingToDequeue:               ;		REPEAT
            CALL QueueEmpty     ;			QueueEmpty(a)
            JE  WaitingToDequeue    ;		UNTIL ( ZeroFlag = 0)
            ;JMP Dequeueing 
    Dequeueing: PUSH BX             ;store registers
                PUSH CX
                PUSH DX
                MOV BX, [SI].Head   ;		AL = item stored in address Head
                MOV AL, [SI].Array[BX]
                PUSH AX
                MOV AX, BX
                INC AX                     ;		Head = Head + 1
                MOV DX, 0
                MOV CX, [SI].QueueSize
                DIV CX                      
                MOV [SI].Head, DX           ;Head = Head/Size


     EndDequeue:POP AX              ;restore registers
                POP DX
                POP CX
                POP BX
                RET             ;		RETURN  
Dequeue          ENDP



;Enqueue(a, b)
;
;Description:		This function adds the passed 8-bit value (b) to the tail 
;of the queue at the passed address (a). If the queue is full it waits until 
;the queue has an open space in which to add the value. It does not return 
;until the value is added to the queue. 
;
;Pseudocode:
;		REPEAT
;			QueueFull(a)
;		UNTIL ( ZeroFlag = 0)
;		[Tail] = b
;	    Tail = Tail + 1
;       Tail = Tail/Size
;		RETURN
;
;
;Arguments: 		The address (a) is passed in SI by value (thus the queue 
;starts at DS:SI) and the value to enqueue (b) is passed by value in AL.
;
;Return Values:	None
;
;Global Variables: 	None
;
;Shared Variables:	None.
;
;Local Variables:	Head, Tail, StartAddress and Size
;
;Inputs:			b, the item to be enqueued
;
;Outputs:		None
;
;Error handling:	None
;
;Algorithms:		Wait until there is space in Queue. Then put item b into 
;address Tail and increment tail pointer. Ensure that we do not exceed queue 
;memory allocation by checking that tail pointer will not go past 
;(StartAddress + Size - 1).
;
;Data Structures:	We will have a Queue Struct which holds the size s of the 
;queue and will keep pointers to the head (front) and tail (end) of the queue.
;
;Limitations:		Will not return until item b is placed in the queue.
;
;Known Bugs: 		None
;
;Special Notes: 	This is a blocking function: It does not return until it 
;puts the value into the queue and will wait until a slot if open to do so.
;
;
;

Enqueue       PROC    NEAR
                PUBLIC  Enqueue


            WaitingToEnqueue:               ;		REPEAT
                CALL QueueFull    ;			QueueFull(a)
                JE  WaitingToEnqueue    ;		UNTIL ( ZeroFlag = 0)
                ;JMP Enqueueing         
            
            Enqueueing:
                PUSH AX                 ;Store Registers
                PUSH BX
                PUSH CX
                PUSH DX
                MOV BX,  [SI].Tail
                MOV [SI].Array[BX], AL  ;		[Tail] = b
                MOV CX, [SI].QueueSize
                MOV DX, 0
                MOV AX, BX
                INC AX                  ;	    Tail = Tail + 1
                DIV CX
                MOV [SI].Tail, DX       ;       Tail = Tail/Size

            EndEnqueue:
                POP DX                  ;Restore Registers
                POP CX
                POP BX
                POP AX
                RET                     ;		RETURN

Enqueue          ENDP

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