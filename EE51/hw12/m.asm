       NAME  MOTOR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                            ;
;                                  MOTOR.ASM                                ;
;                                   motor                        ;
;                                                                      ;
;                                                                            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This file contains the motor functions.
;
; Revision History:
;     3/15/08 Nadine Dabby      Initial Version


$INCLUDE(8255.INC)
$INCLUDE(EH.INC)

CGROUP  GROUP   CODE
DGROUP  GROUP   DATA



CODE    SEGMENT PUBLIC 'CODE'


        ASSUME  CS:CGROUP, DS:DGROUP


EXTRN   Step_Table:BYTE
EXTRN   Cos_Table:WORD
EXTRN   Sin_Table:WORD
EXTRN   Force_Table:WORD


;SetMotorSpeed(speed, angle)
;
;Description:         The function is passed two arguments. The first argument
;(speed) is passed in AX and is the absolute speed (65534 is full speed) at
;which the RoboTrike™ is to run. A speed of 65535 indicates the current
;speed should not be changed, effectively ignoring the speed argument. The
;second argument (angle) is passed in BX and is the signed angle at which
;the RoboTrike™ is to move in degrees, with 0 degrees being straight ahead
;relative to the RoboTrike™ orientation. An angle of -32768 indicates the
;current direction of travel should not be changed, effectively ignoring
;the angle argument.
;
;Pseudocode:                IF (speed < 65535)
;                        THEN
;                                Motor_Speed = speed
;                        IF (angle != -32768)
;                        THEN
;                                Motor_Direction = angle
;                        RETURN
;
;Arguments:         AX holds speed, BX holds angle
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Motor_Speed, Motor_Direction
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        Maximum speed is 65534.
;
;Known Bugs:         None
;
;Special Notes:         None
;
;
SetMotorSpeed       PROC    NEAR
                    PUBLIC  SetMotorSpeed
                    PUSHA
                    CMP AX, 65535
                    JE TrikeAngle
                    MOV Current_Speed, AX
                    
    TrikeAngle: 
                    CMP BX, -32768
                    JE CalculateMotors
                    MOV AX, BX
                    MOV CX, 360
                    DIV CX
                    MOV Current_Angle, AX
                    
    CalculateMotors:
                    MOV DI, 0
                    
    MotorLoop:      CMP DI, 2
                    JG EndSetMotors
                    MOV BP, OFFSET(Force_Table)
                    MOV AX, Current_Speed
                    MOV BX, Current_Angle
                    SHL BX, 1
                    ADD BP, DI
                    IMUL WORD PTR [BP]
                    MOV AX, DX
                    MOV BP, OFFSET(Cos_Table)
                    ADD BP, BX
                    IMUL WORD PTR [BP]
                    PUSH DX
                    
                    MOV AX, Current_Speed
                    MOV BX, Current_Angle
                    SHL BX, 1
                    MOV BP, OFFSET(Force_Table)
                    ADD BP, DI
                    INC BP
                    IMUL WORD PTR [BP]
                    MOV AX, DX
                    MOV BP, OFFSET(Sin_Table)
                    ADD BP, BX
                    IMUL WORD PTR [BP]
                    POP AX
                    ADD DX, AX
                    SAL DX, 1
                    SAR DH, 2 
                    MOV BYTE PTR Motor_Pulse_Width[DI], DH
                    CMP DH, 0
                    JL ReverseDirection
                    MOV BYTE PTR Motor_Pulse_Width[DI], DH
                    MOV BYTE PTR Motor_Direction[DI], 0 ; 0 indicates forward
                    JMP FinishMotorLoop
                    
        ReverseDirection: 
                    NEG DH
                    MOV BYTE PTR Motor_Pulse_Width[DI], DH
                    MOV BYTE PTR Motor_Direction[DI], 1 ; 1 indicates reverse                    
                    ;JMP FinishMotorLoop
                    
        FinishMotorLoop:
                    INC DI
                    JMP MotorLoop
    
    EndSetMotors:
                    
                    POPA
                    RET

SetMotorSpeed          ENDP









;GetMotorSpeed()
;
;Description:         The function is called with no arguments and returns the
;current speed of the RoboTrike™ in AX. A speed of 65534 indicates the
;maximum speed and a value of 0 indicates the RoboTrike™ is stopped. The
;value returned will always be between 0 and 65534 inclusively.
;
;Pseudocode:                AX = Motor_Speed
;                        RETURN
;
;Arguments:         None
;
;Return Values:         The function returns the current speed in AX
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Motor_Speed
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;
;

GetMotorSpeed       PROC    NEAR
                    PUBLIC  GetMotorSpeed
            
                    MOV AX, Current_Speed
                    RET

GetMotorSpeed          ENDP


;GetMotorDirection()
;
;Description:         The function is called with no arguments and returns the
;current direction of movement of the RoboTrike™ as an angle in degrees in
;AX. An angle of zero (0) indicates straight ahead relative to the
;RoboTrike™ orientation and angles are measured clockwise. The value
;returned will always be between 0 and 359 inclusively.
;
;Pseudocode:                AX = Motor_Direction MOD 360
;                        RETURN
;
;Arguments:         None
;
;Return Values:         AX is returned with Motor_Direction
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Motor_Direction
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;
;

GetMotorDirection       PROC    NEAR
                    PUBLIC  GetMotorDirection
            
                    MOV AX, Current_Angle   ;mod 360
                    RET

GetMotorDirection          ENDP



;SetTurretAngle()
;
;Description:         The function is passed a single argument (angle) in AX which
;is the absolute angle (in degrees) at which the turret is to be pointed.
;This angle is unsigned (i.e. positive values only). An angle of zero (0)
;indicates straight ahead relative to the RoboTrike™ orientation and
;non-zero angles are measured clockwise. The turret should rotate through
;the shortest legal angle to the new position.
;
;Pseudocode:                get RelativeAngle
;                            call setRelAngle
;                           RETURN
;
;Arguments:         AX holds angle
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Turret_Angle
;
;Inputs:         None
;
;Outputs:         Turret will rotate to specified angle
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None


SetTurretAngle       PROC    NEAR
                    PUBLIC  SetTurretAngle
            
                    PUSH AX
                    PUSH BX

                    MOV BX, 360     ;for mod function
                    CWD 
                    IDIV BX
                    MOV AX, DX
                    SUB AX, Turret_Position     ;get relative angle
                    CALL SetRelTurretAngle      ;set Relative angle
                    POP BX
                    POP AX
                    RET

SetTurretAngle          ENDP



;GetTurretAngle()
;
;Description:         The function is called with no arguments and returns the
;current absolute angle at which the turret is pointed in degrees in AX. An
;angle of zero (0) indicates the turret is pointed straight ahead relative
;to the RoboTrike™ orientation and angles are measured clockwise. The value
;returned will always be between 0 and 359 inclusively.
;
;Pseudocode:                AX = Turret_Angle
;                        RETURN
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Turret_Angle
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;
;


GetTurretAngle       PROC    NEAR
                    PUBLIC  GetTurretAngle
            
                    MOV AX, Turret_Position        ;mod 360?
                    RET

GetTurretAngle         ENDP







;SetRelTurretAngle(angle)
;
;Description:         The function is passed a single argument (angle) in AX that
;is the relative angle (in degrees) through which to turn the turret. A
;relative angle of zero (0) indicates no movement, positive relative angles
;indicate clockwise rotation, and negative relative angles indicate
;counterclockwise rotation. The angle is relative to the current turret
;position.
;
;Pseudocode:                angle = angle MOD 360
;IF (angle > 0)
;                                Direction = clockwise
;                        ELSE   Direction = CounterClockWise
;Turret_Angle = Turret_Angle + angle
;RETURN
;
;Arguments:         AX holds angle
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Turret_Angle, Direction
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;


SetRelTurretAngle       PROC    NEAR
                    PUBLIC  SetRelTurretAngle
            PUSHA
            ;MOV BX, 360     ;for mod function
            ;CWD 
            ;IDIV BX
			;MOV CX, Step_Direction
			;MOV Old_Step_Direction, CX
            MOV DX, AX
			CMP DX, 180
            JG NegTurret
            CMP DX, -180
            JL PosTurret
			
			CMP DX, 0
			JL NegTurret
			
            JMP PosTurret    ;positive direction     
            
NegTurret:
            MOV Step_Direction, 1  ;negative direction

            MOV CX, 360
			CMP DX, 0
			JG NegButPosTurret
			MOV CX, DX
			JMP EndNegTurret
NegButPosTurret:
			SUB CX,DX
			NEG CX
			;JMP EndNegTurret
			
EndNegTurret:        
			MOV AX, CX
			MOV CX, Turret_Position
			ADD CX, AX
			MOV BX, AX	;stores movement amt
			JMP EndTurret

 
PosTurret:
            MOV Step_Direction, -1  ;positive direction
            MOV CX, 360
			CMP DX, 0
			JL PosButNegTurret
			MOV CX, DX
			JMP EndPosTurret


PosButNegTurret:
            ADD CX, DX			
			;JMP EndPosTurret
			
EndPosTurret:
            MOV AX, CX
			MOV CX, Turret_Position
			ADD CX, AX
			MOV BX, AX   	;stores movement amt
            ;JMP EndTurret     			
            
EndTurret:  ;MOV BX, AX
            MOV AX, CX
            CWD
            MOV CX, 360
            IDIV CX
            MOV Turret_Position, DX	;new position
            MOV AX, BX
            CMP AX, 0
			JGE PositivePosition
			NEG AX
			JMP PositivePosition
	
PositivePosition:
            MOV CX, 10
			CWD
            IMUL CX
            MOV CX, 18
			CWD
            IDIV CX
            ADD Turret_Step_Count, AX      ; add AX to step
            
            POPA
            RET

SetRelTurretAngle          ENDP


;SetLaser(onoff)
;
;Description:         The function is passed a single argument (onoff) in AX that
;indicates whether to turn the RoboTrike™ laser on or off. A zero (0) value
;turns the laser off and a non-zero value turns it on. The Laser is turned on/off
;by the event handler.
;
;Pseudocode:                Laser = onoff
;                        RETURN
;
;Arguments:         AX holds onoff
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Laser
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None


SetLaser        PROC    NEAR
                PUBLIC  SetLaser
            
                    MOV Current_Laser, AX 
                    RET

SetLaser        ENDP




;GetLaser()
;
;Description:         The function is called with no arguments and returns the
;status of the RoboTrike™ laser in AX. A value of zero (0) indicates the
;laser is off and a non-zero value indicates it is on.
;
;Pseudocode:                AX = Laser
;                        RETURN
;
;Arguments:         None
;
;Return Values:         AX will be returned with LASER in it.
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Laser
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;

GetLaser        PROC    NEAR
                PUBLIC  GetLaser
            
                    MOV AX, Current_Laser
                    RET

GetLaser        ENDP



;StepperTimerEH()
;
;Description:         This timer event handler steps the turret motor at a fixed
;or variable rate.The stepper motor for rotating the turret on the RoboTrike™ is 
;connected to the low 4 bits of Port C of the 8255. This stepper has 3.6º full-
;steps (and thus 1.8º half-steps). There is no gearing, thus this is also the 
;angle through which the laser will rotate. Winding A of the stepper is connected 
;to Port C bits 0 and 1 and winding B is connected to Port C bits 2 and 3.
;
;Pseudocode:                IF (TimerCount = StepperTimerCount)
;                                StepperMotor = on   at Stepper_Speed
;                        ENDIF
;                        RETURN
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         StepperTimerCount, Stepper_Speed
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;
;


StepperTimerEH        PROC    NEAR
                        PUBLIC  StepperTimerEH
            
                PUSHA
                MOV AX, Turret_Step_Count
                CMP AX, 0
                JE NoStep
                DEC AX
                MOV Turret_Step_Count, AX
                MOV AX, Turret_Table_Index
                MOV CX, Step_Direction   
                ADD AX, CX
                CMP AX, 8
                JE StepOver7
                CMP AX, -1
                JE StepUnder0
                JMP RetrieveStepperIndex
                
    StepOver7:
                MOV AX, 0
                JMP RetrieveStepperIndex
                
    StepUnder0:
                MOV AX, 7
                ;JMP RetrieveStepperIndex
                
    RetrieveStepperIndex:
                MOV Turret_Table_Index, AX
                ;MOV AH, 0
                MOV BX, OFFSET(Step_Table)
                XLAT CS:Step_Table
                MOV DX, PORT_C
                OUT DX, AL
                
                  

        NoStep:          
                  
                MOV     DX, INTCtrlrEOI  ;send the EOI to the interrupt controller
                MOV     AX, TimerEOI
                OUT     DX, AL

                POPA
                IRET       ;and return (Event Handlers end with IRET not RET)


StepperTimerEH        ENDP



;MotorSpeedTimerEH()
;
;Description:         This event handler controls the speed of the motors. It does
;so by running each motor for a certain amount of time within the event dictated 
;by it's pulse motor width and its direction. Bits 0 and 1 of Port B control 
;motor 1, bits 2 and 3 of Port B control motor 2, and bits 4 and 5 of Port B 
;control motor 3. The direction of the motors is controlled by bits 0, 2, and 4 
;of Port B (one bit for each motor). The motors are turned on or off via bits 1,
;3, and 5 of Port B (again one bit for each motor). The speed is controlled by 
;using PWM (pulse-width modulation) on bits 1, 3, and 5 of Port B.
;
;Pseudocode:                IF (TimerCount = MotorTimerCount)
;                        Use Motor_Direction to set M1_Speed, M2_Speed, M3_Speed
;        Motor1 = on   at M1_Speed
;                                Motor2 = on   at M2_Speed
;                                Motor3 = on   at M3_Speed
;                        ENDIF
;                        RETURN
;
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         MotorTimerCount, M1_Speed, M2_Speed, M3_Speed
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         This handles laser too.
;

MotorSpeedTimerEH        PROC    NEAR
                        PUBLIC  MotorSpeedTimerEH
            
                    PUSHA
                    MOV AX,  PWM_Count   ;increment pulse count
                    INC AX
                    AND AX, 31          ;mod 32
                    MOV PWM_Count, AX
                    MOV DI, 0           ;set index to 0 
                    MOV BX, 0
                    MOV CX, 0
                    MOV BL, BYTE PTR Motor_Pulse_Width[DI]
                    MOV CL, BYTE PTR Motor_Direction[DI]
                    MOV DX, 0
                    OR DX, CX       ;OR DX with Motor1 direction
                    CMP AX, BX
                    JG Motor2ON     ;default value is off
                    OR DX, 0002H    ;set bit 1 to 1
                    ;JMP Motor2ON
        
        Motor2ON:   INC DI
                    MOV BL, BYTE PTR Motor_Pulse_Width[DI]
                    MOV CL, BYTE PTR Motor_Direction[DI]
                    SHL CL, 2       ;Shift CL to OR bit 2
                    OR DX, CX       ;OR DX with Motor2 direction
                    CMP AX, BX
                    JG Motor3ON     ;default value is off
                    OR DX, 0008H    ; set bit 3 to 1
                    ;JMP Motor3ON                 
        
        Motor3On:   INC DI
                    MOV BL, BYTE PTR Motor_Pulse_Width[DI]
                    MOV CL, BYTE PTR Motor_Direction[DI]
                    SHL CL, 4       ;shift CL to OR bit 4
                    OR DX, CX       ;OR DX with Motor2 direction
                    CMP AX, BX
                    JG EndMotorSpeedTimerEH ;default value is off
                    OR DX, 0020H    ; set bit 5 to 1
                    ;JMP EndMotorSpeedTimerEH
                    
        EndMotorSpeedTimerEH:
                    MOV CX, Current_Laser ;now set laser
                    CMP CX, 0
                    JE NoLaser
                    MOV CX, 1
                    JMP YesLaser
                    
        NoLaser:    MOV CX, 0
                    ;JMP YesLaser
                    
        YesLaser:  SHL CX, 7
                    OR DX, CX       ;OR DX with laser bit
                    MOV AX, DX      ; mov the output into AX
                    MOV DX, PORT_B  ;put port B address into DX
                    OUT DX, AL      ;output pulse
                    
                    MOV     DX, INTCtrlrEOI  ;send the EOI to the interrupt controller
                    MOV     AX, TimerEOI
                    OUT     DX, AL

                    POPA
                    IRET       ;and return (Event Handlers end with IRET not RET)


MotorSpeedTimerEH        ENDP


;MotorInit()
;
;Description:         This function initializes motor variables.
;
;Pseudocode:          Motor speeds = 0
;                       Motor Angles = 0
;                     Timer Counts = 0
;                       Laser = off
;                       Turret dir = 0
;
;Arguments:         None
;
;Return Values:         None
;
;Global Variables:         None
;
;Shared Variables:        None
;
;Local Variables:         Motor_Pulse_Width, Motor_Direction, PWM_Count, 
;Current_Angle, Current_Speed, Current_Laser, Turret_Step_Count, Step_Direction, 
;Turret_Position 
;
;Inputs:         None
;
;Outputs:         None
;
;Error handling:        None
;
;Algorithms:        None
;
;Data Structures:        None
;
;Limitations:        None
;
;Known Bugs:         None
;
;Special Notes:         None
;
;

MotorInit        PROC    NEAR
                        PUBLIC  MotorInit
            
                    PUSHA
                    MOV DI, 0
        MotorInitLoop:
                    CMP DI, 2
                    JG EndMotorInitLoop
                    MOV BYTE PTR Motor_Pulse_Width[DI], 0
                    MOV BYTE PTR Motor_Direction[DI], 0
                    INC DI
                    JMP MotorInitLoop
                    
        EndMotorInitLoop:
                    MOV PWM_Count, 0
                    MOV Current_Angle, 0
                    MOV Current_Speed, 0
                    MOV Current_Laser, 0
                    MOV Turret_Step_Count, 0
                    MOV Step_Direction, -1
					MOV Old_Step_Direction, -1
                    MOV Turret_Position, 0
                    MOV Turret_Table_Index, 0
                    
                    POPA
                    RET

MotorInit        ENDP

CODE ENDS

DATA    SEGMENT PUBLIC  'DATA'

Motor_Pulse_Width  	DB    3 DUP (?)     ; array of motor pulse width
Motor_Direction     DB    3 DUP (?)     ; array of Motor Direction
PWM_Count           DW          ?
Current_Angle       DW          ?   ; current angle of robotrike
Current_Speed       DW          ?   ; current speed of robotrike
Current_Laser       DW          ?   ; laser on or off 
Turret_Step_Count   DW          ?
Turret_Table_Index  DW          ?   ;index into Stepper Table
Step_Direction      DW          ?   ; Direction -1 (Positive), 1 (negative)
Old_Step_Direction  DW			?
Turret_Position     DW          ?   ;current position of turret

DATA    ENDS

    END