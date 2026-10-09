extends CharacterBody2D

var direction : Vector2 = Vector2.UP
@export var maxSpeed : float = 100.0
@export var maxTurnSpeed : float = 2.0
@export var acceleration : float = 10.0
@export var deceleration : float = 30.0
@export var turnAccel : float = 1.0
@export var turnDeccel : float = 2.0
@export var sprite : Sprite2D
var ignition : bool = false
var forwardSpeed : float = 0
var turningSpeed : float = 0

func _input(event: InputEvent) -> void:
	pass
	#if Input.is_action_just_pressed("gas_pedal"):
		#ignition = true
	#
	#if Input.is_action_just_released("gas_pedal"):
		#ignition = false
	

func rotating(delta: float):
	direction = direction.rotated(turningSpeed * delta)
	sprite.rotate(turningSpeed * delta)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("gas_pedal"):
		var accel = acceleration * delta
		forwardSpeed = clampf(forwardSpeed + accel, 0, maxSpeed)
	else:
		var deccel = deceleration * delta
		forwardSpeed = clampf(forwardSpeed - deccel, 0, maxSpeed)
	if Input.is_action_pressed("turn_left"):
		turningSpeed = clampf((turningSpeed - (turnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	elif Input.is_action_pressed("turn_right"):
		turningSpeed = clampf((turningSpeed + (turnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	else:
		if turningSpeed < 0:
			turningSpeed = clampf((turningSpeed + (turnDeccel * delta)), -maxTurnSpeed, 0)
		elif turningSpeed > 0:
			turningSpeed = clampf((turningSpeed - (turnDeccel * delta)), 0, maxTurnSpeed)
	velocity = forwardSpeed * direction
	rotating(delta)
	move_and_slide()
	print(velocity)
