       NAME  SERIAL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  S.ASM                                ;
;                                   Serial                        ;
;                                                                      ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the serial functions.
;
; Revision History:
;     3/15/08 Nadine Dabby      Initial Version


$INCLUDE(SERIAL.INC)
$INCLUDE(QUEUE.INC)
$INCLUDE(EH.INC)

CGROUP  GROUP   CODE
DGROUP  GROUP   DATA



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP
        
;external function declarations

        EXTRN   QueueInit:NEAR
        EXTRN   QueueEmpty:NEAR
        EXTRN   QueueFull:NEAR
        EXTRN   Dequeue:NEAR
        EXTRN   Enqueue:NEAR



;RoboTrike™ Serial Routines
;
;SerialInRdy()
;
;Description: 	The function is called with no arguments and returns with the 
;zero flag reset if there is a character available from the serial channel and 
;the zero flag set otherwise. 
;
;Pseudocode:		
;	IF (ReceiveQueue != empty)
;		ZeroFlag = 0
;	ELSE	ZeroFlag = 1
;	RETURN
;
;Arguments: 	None
;
;Return Values: 	Zero Flag (0 if char, 1 if no char)
;
;Global Variables: 	None
;
;Shared Variables:	TransmitQueue
;
;Local Variables:	None
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	QueueEmpty() function from queue.asm
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	This function does not look at the bits in the serial 
;controller status registers, its return status is based on the "condition" of 
;the receive queue.
;
; 

SerialInRdy        PROC    NEAR
                   PUBLIC  SerialInRdy
                   
                PUSH SI
                MOV SI, OFFSET(ReceiveQueue);
                Call QueueEmpty   ;IF (ReceiveQueue != empty)
                                    ;		ZeroFlag = 0
                                    ;	ELSE	ZeroFlag = 1
                                ;	RETURN            
                POP SI
                RET             ;	RETURN 

SerialInRdy        ENDP




;
;SerialGetChar()
;
;Description: 	The function is called with no arguments and returns with the 
;next character from the serial channel in AL and the current error status in 
;the carry flag. The routine does not return until it has a received character. 
;
;Pseudocode:    carry flag = error status
;                AL = next char
;                RET
;	
;Arguments: 	None
;
;Return Values: 	AL holds next character from serial channel. Carry Flag 
;indicates error
;
;Global Variables: 	None
;
;Shared Variables:	
;
;Local Variables:	 
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	On return the carry flag is set if there has been an error 
;on the serial channel (for more detailed error information use the 
;SerialStatus() function). This function should not reset the error state. 
;
;
;Algorithms:	None
;
;Data Structures:	Queue
;
;Limitations:	
;
;Known Bugs: 	None
;
;Special Notes: 	The routine does not return until it has a received 
;character. (Need to make sure we don’t end up in one of the queue blocking 
;functions)
;
;

SerialGetChar       PROC    NEAR
                    PUBLIC  SerialGetChar
            PUSH SI
            PUSH BX
            MOV SI, OFFSET(ReceiveQueue); puts char in AL
            CALL Dequeue
            MOV BL, NO_SERIAL_ERROR
            CMP BL, SerialError   ;sets carry flag if the second thing is bigger
                                  ;carry flag = error status
            POP BX
            POP SI
            RET;                RET



SerialGetChar        ENDP

;SerialOutRdy()
;
;Description: 	The function is called with no arguments and returns with the 
;zero flag reset if the serial channel is ready for another character to 
;transmit and the zero flag set otherwise. 
;
;Pseudocode:	IF (transmitQueue != full)
;					ZeroFlag = 0
;				ELSE	ZeroFlag = 1
;				RETURN
;
;	
;
;Arguments: 	None
;
;Return Values: 	Zero Flag (0 if channel is ready, 1 otherwise)
;
;Global Variables: 	None
;
;Shared Variables:	ReceiveQueue
;
;Local Variables:	None
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	use function QueueFull from queue.asm
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	This function does not look at the bits in the serial 
;controller status registers, its return status is based on the "condition" of 
;the transmit queue.	
;
;
;
SerialOutRdy        PROC    NEAR
                        PUBLIC  SerialOutRdy
            
                PUSH SI
                MOV SI, OFFSET(TransmitQueue);
                Call QueueFull  ;IF (transmitQueue != full)
                                ;		ZeroFlag = 0
                                ;ELSE	ZeroFlag = 1
                                ;RETURN                      
                POP SI
                RET             ;	RETURN ;                  


SerialOutRdy        ENDP
;
;SerialPutChar(c)
;
;Description: 	The function outputs the passed character (c) to the serial 
;channel. It does not return until the character has been put in the channel’s 
;queue. The character (c) is passed by value in AL.	 
;
;Pseudocode:		Enqueue(Queue, AL)
;			RETURN
;	
;
;Arguments: 	AL holds character (c)
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	ReceiveQueue, TransmitQueue
;
;Local Variables:	 None
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	Need to make sure there is room in the queue so as not to 
;get stuck in the Enqueue blocking function. ALSO NEED to KICKSTART!
;(so as not to end up with no more transmits ever)
;
;
SerialPutChar        PROC    NEAR
                     PUBLIC  SerialPutChar
            PUSH SI
            PUSH DX
            PUSH AX
            MOV SI, OFFSET(TransmitQueue)
            CALL Enqueue
            CMP Kicker, 0
            JE Kickstart
            JMP EndSerialPutChar
    Kickstart:
            MOV Kicker, 1
            INT 14
            ;JMP EndSerialPutChar
            
    EndSerialPutChar:
            POP AX
            POP DX
            POP SI
            RET;                RET


SerialPutChar        ENDP


;SerialStatus()
;
;Description: 	The function returns the error status for the serial channel in AL. 
;
;Pseudocode:		AL = error bit
;	RETURN 
;
;Arguments: 	None
;
;Return Values: 	AL holds error status
;
;Global Variables: 	None
;
;Shared Variables:	SerialError
;
;Local Variables:	None 
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	None
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	Potentially Critical Code
;
;

;
SerialStatus        PROC    NEAR
                    PUBLIC  SerialStatus
            PUSH DX
            MOV DX, SERIAL_ERROR_ADDRESS
            PUSHF
            CLI                 ;stop interrupts
            IN AL, DX
            AND AL, SERIAL_ERROR_READ
            MOV SerialError, AL
            IN AL, DX
            AND AL, SERIAL_ERROR_CLEAR
            OUT DX, AL
            POPF                 ;start interrupts
            MOV AL, SerialError
            POP DX
            RET;	RETURN 
                    

SerialStatus        ENDP
;
;
;SetSerialBaudRate(b)
;
;Description: 	 This function sets the serial baud rate to 110, 300, 1200, 
;4800, 9600, 19200, 57600. b, The choice of these (0 to 6) is passed in AX
;
;Pseudocode:		
;				;PUSHF
;               Turn off interrupts
;               BaudNo = AX
;               Look up Divisor in BaudTable
;               Baud_Rate = 
         ;       RETURN
                ;POPF
;	
;
;Arguments: 	b is passed in AX
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	 BaudNumber
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	Baud_Table
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	Critical code, we must turn off interrupts and then turn them 
;on again.
;
;
SetSerialBaudRate        PROC    NEAR
                        PUBLIC  SetSerialBaudRate
            
            PUSHA
            MOV BP, OFFSET(Baud_Table)
            SHL AX, 1           ;multiply AX by 2 to index into table
            ADD BP, AX

            MOV DX, DLAB_ADDRESS
            MOV AX, 0
            IN AL, DX
            
            
            PUSHF
            CLI             ;turn off interrupts
            
            OR AL, SET_DLAB_BIT     
            OUT DX, AL          ;set DLAB bit
            
            MOV AL, CS:[BP]
            MOV DX, LOW_BAUD_DIVISOR_ADDRESS
            OUT DX, AL
            
            INC BP
            MOV AL, CS:[BP]           
            
            MOV DX, HIGH_BAUD_DIVISOR_ADDRESS
            OUT DX, AL            
            
            MOV DX, DLAB_ADDRESS
            MOV AX, 0
            IN AL, DX


            AND AL, CLEAR_DLAB_BIT  ;clear dlab bit
            OUT DX, AL          ;set DLAB bit
                    
            POPF            ;turn off interrupts
            POPA
            RET

                    

SetSerialBaudRate        ENDP
;
;SetSerialParity()
;
;Description: 	 This function sets the serial parity: none (0) even (1), odd (2)
;The choice is passed in AL.  
;
;
;Pseudocode:		
;			
;	
;
;Arguments: 	AL holds choice for parity
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	 none
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	parity table
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;

SetSerialParity        PROC    NEAR
                        PUBLIC  SetSerialParity
            PUSHA
            MOV  BX, OFFSET(Parity_Table)
            XLAT    CS:Parity_Table     ;save bitmask in AL
            MOV BX, 0
            MOV BL, AL
            MOV DX, LCR_ADDRESS            
            IN AL, DX
            AND AL, BL          ; and with bitmask
            OUT DX, AL          ;output new parity
            POPA
            RET

SetSerialParity        ENDP
;
;
;
;
;SerialInit()
;
;Description: 	This function initializes the serial I/O., including setting up 
;serial communication and initializing transmit and receive queues.
;
;Pseudocode:	
;            AX = 4
;            SI = OFFSET(ReceiveQueue)
;            CALL QueueInit
;            SI = OFFSET(TransmitQueue)
;            CALL QueueInit
;			SerialError = 00H
;	RETURN
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	TransferQueue, ReceiveQueue
;
;Local Variables:	 None
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;

SerialInit        PROC    NEAR
                        PUBLIC  SerialInit
            PUSHA
            MOV DX, LCR_ADDRESS            
            MOV AL, INIT_LCR          ; and with bitmask
            OUT DX, AL          ;output new LCR

            MOV DX, IER_ADDRESS            
            MOV AL, INIT_IER          ; and with bitmask
            OUT DX, AL          ;output new LCR


            MOV AX, 4
            MOV SI, OFFSET(ReceiveQueue)
            CALL QueueInit
            MOV SI, OFFSET(TransmitQueue)
            CALL QueueInit
            MOV Kicker, 00H    ;set kickstart to 0
            MOV SerialError, 00H    ;set serial errors to 0
            MOV SerialOverflowError, 00H    ;set overflow error to 0 
            CALL  SetSerialBaudRate      ;4 happens to be the divisor for 9600
            
            MOV AL, 1                   ;set even parity
            CALL SetSerialParity
            POPA
            RET
                    

SerialInit        ENDP

;
;SerialEH()
;
;Description: 	This function defines the Serial Event Handler. It is interrupt 
;driven. There are three types of interrupts: Error, receiving and transmitting.
;we first need to figure out what type of interrupt we have, then we need to 
;deal with it appropriately 
;
;Pseudocode: Event = Read Serial IIR
;			IF (event = input )
;			THEN 
;				CALL ReceiveHandler
;			ELSEIF (event = output)
;				Call TransmitHandler
;			ELSE CALL SerialErrorHandler
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	 event
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	Read Error, Transmit Error handled by called functions
;
;Algorithms:	None
;
;Data Structures:	EventHandler Table
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;

SerialEH        PROC    NEAR
                        PUBLIC  SerialEH
                PUSHA
                
      ;   DW  OFFSET(DoNothing); 00 = Modem status
       ; DW  OFFSET(TransmitHandler); 01 = Transmit interrupt
        ;DW  OFFSET(ReceiveHandler); 10 = Receive Interrupt
        ;DW  OFFSET(SerialErrorHandler); 11 = Error   
                       
 ;            Event = Read Serial IIR
                MOV AX, 0
                MOV DX, IIR_ADDRESS
                MOV BP, OFFSET(SEH_Table)
                IN  AL, DX
                TEST AL, 1
                JNZ AdjustKickstartEntry
                AND AL, IIR_READ
                ADD BP, AX
                JMP KickstartEntry
    AdjustKickstartEntry:
                ADD BP, 2
                ;JMP KickstartEntry

    KickstartEntry:
                MOV BX, WORD PTR CS:[BP]
                CALL BX ;			IF (event = input )
                        ;			THEN 
                        ;				CALL ReceiveHandler
                        ;			ELSEIF (event = output)
                        ;				Call TransmitHandler
                        ;			ELSE CALL SerialErrorHandler 
           
                MOV     DX, INTCtrlrEOI  ;send the EOI to the interrupt controller
                MOV     AX, INT2EOI
                OUT     DX, AL
                POPA
                IRET       ;and return (Event Handlers end with IRET not RET)
    

SerialEH        ENDP

;ReceiveHandler()
;
;Description: 	This function defines the Receive Handler. It is called from 
;SerialEH() when a transmit interrupt is received.
;
;Pseudocode:		
;			IF (event = input )
;			THEN 
;				IF (QueueFull(ReceiveQueue))
;				THEN    Serial Error = ReceiveQueue Overflow
;				ELSE     AL = ReadData
;					   Enqueue(ReceiveQueue, AL)
;				ENDIF
;           ENDIF
;			
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	serialerror
;
;Local Variables:	 serialerror, ReceiveQueue
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;
ReceiveHandler        PROC    NEAR
                        PUBLIC  ReceiveHandler
            
            PUSHA    
            MOV SI, OFFSET(ReceiveQueue)
            MOV DX, SERIAL_BASE_ADDRESS 
            IN AL, DX                   ;    AL = ReadData
            CALL QueueFull    ;IF (QueueFull(ReceiveQueue))	
            JE RXQueueFull    ;Deal with overflow
            MOV SerialOverflowError, 0  ;clear overflow 
            CALL Enqueue    ;    Enqueue(ReceiveQueue, AL)
            JMP EndReceiveHandler
    RXQueueFull:
            MOV SerialOverflowError, 1 ;THEN    Serial Error = ReceiveQueue Overflow
            ;JMP EndReceiveHandler
    EndReceiveHandler:
            POPA
            RET
ReceiveHandler        ENDP


;TransmitHandler()
;
;Description: 	This function defines the Transmit Handler. It is called from 
;SerialEH() when a transmit interrupt is received.
;
;Pseudocode:		
;				IF (QueueEmpty(TransmitQueue))	
;		        THEN  Turn Off Transmit interrupts
;		        ELSE	  AL = Dequeue(TransmitQueue, AL)
;			              OUT(serialport, AL)
;
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	TransmitQueue, serialerror
;
;Local Variables:	 serialerror
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	Serial Error, 
;
;Algorithms:	None
;
;Data Structures:	Queue
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;
TransmitHandler        PROC    NEAR
                        PUBLIC  TransmitHandler
            PUSHA    
            MOV SI, OFFSET(TransmitQueue)
            CALL QueueEmpty    ;	IF (QueueEmpty(TransmitQueue))	
            JE TXQueueEmpty 
            JMP TXHasSomething
            
            
    TXQueueEmpty:
            MOV Kicker, 0
            ;MOV DX, THRE_ADDRESS
            ;IN AL, DX
            ;AND AL, DISABLE_THRE   ;THEN  Turn Off Transmit interrupts		
            ;OUT DX, AL
            
            JMP EndTransmitHandler
            

   TXHasSomething:         
            MOV DX, SERIAL_BASE_ADDRESS

            CALL Dequeue;     AL = Dequeue(TransmitQueue, AL)
            OUT  DX, AL       ;	OUT(serialport, AL) 
            ;JMP EndTransmitHandler
                        
    EndTransmitHandler:
            POPA
            RET
        
TransmitHandler        ENDP
;
;
;SerialErrorHandler()
;
;Description: 	This function defines the Error Handler. It is called from 
;SerialEH() when an error  interrupt is received. 
;
;Pseudocode:		
;               Serial Error = Read Error State
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	serialerror
;
;Local Variables:	 serialerror
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling:	None
;
;Algorithms:	None
;
;Data Structures:	None
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;
SerialErrorHandler        PROC    NEAR
                        PUBLIC  SerialErrorHandler
            
                CALL SerialStatus   ;   Serial Error = Read Error State
                RET

SerialErrorHandler        ENDP

;DoNothing()
;
;Description: 	This function defines simply returns, it is called when a 
; modem interrupt happens since we don't care about the modem
;
;Pseudocode: RETURN
;
;Arguments: 	None
;
;Return Values: 	None
;
;Global Variables: 	None
;
;Shared Variables:	None
;
;Local Variables:	 None
;
;Inputs: 	None
;
;Outputs: 	None
;
;Error handling: None
;
;Algorithms:	None
;
;Data Structures:None
;
;Limitations:	None
;
;Known Bugs: 	None
;
;Special Notes: 	None
;
;

DoNothing       PROC    NEAR
                PUBLIC  DoNothing
                
                RET ;return
            
DoNothing        ENDP


; SEH_Table 
;
; Description:      This is the serial event handler table
;
; Notes:            READ ONLY table
;
; Author:           Nadine Dabby
; Last Modified:    March 15, 2008

SEH_Table       LABEL   Word
                PUBLIC  SEH_Table

                ;       DW      address of function to call
                ;based on looking at bits 2,1 of IIR
			
        DW  OFFSET(DoNothing); 00 = Modem status
        DW  OFFSET(TransmitHandler); 01 = Transmit interrupt
        DW  OFFSET(ReceiveHandler); 10 = Receive Interrupt
        DW  OFFSET(SerialErrorHandler); 11 = Error   
        
        
; Baud_Table 
;
; Description:      This is the Baud_Rate divisor table.We calculate the 
;divisor using the equation: divisor = 576000/baud_rate
;
; Notes:            READ ONLY table
;
; Author:           Nadine Dabby
; Last Modified:    March 18, 2008
        
Baud_Table      LABEL   Word
                PUBLIC  Baud_Table
 
        DW  5236        ;divisor for 110
        DW  1920        ;divisor for 300
        DW  480        ;divisor for 1200
        DW  120        ;divisor for 4800
        DW  60        ;divisor for 9600
        DW  30        ;divisor for 19200
        DW  10        ;divisor for 57600
        
        
; Parity_Table 
;
; Description:      This is the Parity options table. It provides the bitmasks 
;setting the appropriate parity.
;
; Notes:            READ ONLY table
;
; Author:           Nadine Dabby
; Last Modified:    March 18, 2008
        
Parity_Table      LABEL   BYTE
                    PUBLIC  Parity_Table
 
        DB  11110011B    ;no parity mask
        DB  11111111B    ;even parity mask
        DB  11110111B    ;odd parity mask

CODE ENDS

;Data segment
;

DATA    SEGMENT PUBLIC  'DATA'
ReceiveQueue    QUEUE < >   ;receive queue
TransmitQueue   QUEUE < >   ;transmit queue
SerialError     DB  ?       ;serialerror shared var
SerialOverflowError   DB  ?       ;Error in case of overflow
Kicker          DB  ?

DATA    ENDS

    END