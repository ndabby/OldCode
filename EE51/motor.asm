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
            
                    MOV AX, MOTOR_SPEED
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
            
                    MOV AX, MOTOR_DIRECTION   ;mod 360?
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
            
                    MOV AX, MOTOR_DIRECTION   ;mod 360?
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
            
                    MOV AX, TURRET_ANGLE        ;mod 360?
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





;SetLaser(onoff)
;
;Description:         The function is passed a single argument (onoff) in AX that
;indicates whether to turn the RoboTrike™ laser on or off. A zero (0) value
;turns the laser off and a non-zero value turns it on.
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
            
                    MOV LASER, AX 
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
            
                    MOV AX, LASER
                    RET

GetLaser        ENDP



;StepperTimerEH()
;
;Description:         This timer event handler steps the turret motor at a fixed
;or variable rate.
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






;MotorSpeedTimerEH()
;
;Description:         This event handler controls the speed of the motors. It does
;so by running each motor for a certain amount of time within the event.
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
;Special Notes:         None
;



DATA    SEGMENT PUBLIC  'DATA'

M1_PULSE_WIDTH      DW          ?
M2_PULSE_WIDTH      DW          ?
M3_PULSE_WIDTH      DW          ?
M1_DIRECTION        DW          ?
M2_DIRECTION        DW          ?
M3_DIRECTION        DW          ?
PWM_COUNT           DW          ?
CURRENT_ANGLE   DW          ?
CURRENT_SPEED       DW          ?
CURRENT_LASER               DW          ?
CURRENT_TURRET_ANGLE        DW          ?
TURRET_STEP_COUNT   DW          ?
TURRET_POSITION     DW          ?

DATA    ENDS