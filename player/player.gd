extends CharacterBody2D

var direction : Vector2 = Vector2.UP
@export var maxSpeed : float = 100.0
@export var maxTurnSpeed : float = 5.0
@export var acceleration : float = 10.0
@export var deceleration : float = 30.0
@export var turnAccel : float = 1.0
@export var turnDeccel : float = 0.5
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
	
	

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("gas_pedal"):
		var accel = acceleration * delta
		forwardSpeed = clampf(forwardSpeed + accel, 0, maxSpeed)
	else:
		var deccel = deceleration * delta
		forwardSpeed = clampf(forwardSpeed - deccel, 0, maxSpeed)
	if Input.is_action_pressed("turn_left"):
		direction = direction.rotated(-turnAccel * delta)
		sprite.rotate(-turnAccel * delta)
	elif Input.is_action_pressed("turn_right"):
		direction = direction.rotated(turnAccel * delta)
		sprite.rotate(turnAccel * delta)
	velocity = forwardSpeed * direction
	move_and_slide()
	print(velocity)
