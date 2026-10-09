extends CharacterBody2D

var direction : Vector2 = Vector2.UP

@export var maxSpeed : float = 100.0
@export var maxBrakingSpeed : float = 20.0
@export var maxTurnSpeed : float = 2.0

@export var acceleration : float = 10.0
@export var deceleration : float = 30.0
@export var brakingAccel : float = 5.0
@export var brakingDecel : float = 50.0

@export var turnAccel : float = 1.0
@export var turnDeccel : float = 4.0
@export var breakingTurnAccel : float = 2.0
@export var breakingTurnDeccel : float = 1.5

@export var sprite : Sprite2D

var forwardSpeed : float = 0
var turningSpeed : float = 0

func _input(event: InputEvent) -> void:
	pass
	

func rotating(delta: float):
	direction = direction.rotated(turningSpeed * delta)
	sprite.rotate(turningSpeed * delta)

func _physics_process(delta: float) -> void:#
	# Check if player is breaking
	
	var activeMaxSpeed = 0.0
	var activeAccel = 0.0
	var activeDecel = 0.0
	var activeTurnAccel = 0.0
	var activeTurnDecel = 0.0
	
	if Input.is_action_pressed("brakes"):
		activeMaxSpeed = maxBrakingSpeed
		activeAccel = brakingAccel
		activeDecel = brakingDecel
		activeTurnAccel = breakingTurnAccel
		activeTurnDecel = breakingTurnDeccel
	else:
		activeMaxSpeed = maxSpeed
		activeAccel = acceleration
		activeDecel = deceleration
		activeTurnAccel = turnAccel
		activeTurnDecel = turnDeccel
	
	# Movement Code
	# Forward and Reverse car movement
	
	if Input.is_action_pressed("gas_pedal"):
		var accel = activeAccel * delta
		forwardSpeed = clampf(forwardSpeed + accel, -maxSpeed, maxSpeed)
	elif Input.is_action_pressed("reverse"):
		var accel = activeAccel * delta
		forwardSpeed = clampf(forwardSpeed - accel, -maxSpeed, maxSpeed)
	else:
		var deccel = activeDecel * delta
		if forwardSpeed > 0:
			forwardSpeed = clampf(forwardSpeed - deccel, 0, maxSpeed)
		elif forwardSpeed < 0:
			forwardSpeed = clampf(forwardSpeed + deccel, -maxSpeed, 0)
	
	# Turning movement
	
	if Input.is_action_pressed("turn_left"):
		turningSpeed = clampf((turningSpeed - (activeTurnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	elif Input.is_action_pressed("turn_right"):
		turningSpeed = clampf((turningSpeed + (activeTurnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	else:
		if turningSpeed < 0:
			turningSpeed = clampf((turningSpeed + (activeTurnDecel * delta)), -maxTurnSpeed, 0)
		elif turningSpeed > 0:
			turningSpeed = clampf((turningSpeed - (activeTurnDecel * delta)), 0, maxTurnSpeed)
	
	# Set velocity
	
	velocity = forwardSpeed * direction
	
	# Call rotating function
	
	rotating(delta)
	move_and_slide()
	print(velocity)
