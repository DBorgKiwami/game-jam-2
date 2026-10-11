extends CharacterBody2D
class_name Car

var direction : Vector2 = Vector2.UP
var directionBeforeBreak : Vector2 = Vector2.UP
var inStorm := false
var offroad := false

@onready var fog_reference : ColorRect = get_tree().get_first_node_in_group("fog")
@export var maxSpeed : float = 100.0
@export var maxBrakingSpeed : float = 20.0
@export var maxTurnSpeed : float = 2.0

@export var acceleration : float = 10.0
@export var deceleration : float = 30.0
@export var brakingAccel : float = 5.0
@export var brakingDecel : float = 50.0
@export var crashSpeedMultiplier : float = 0.1

@export var turnAccel : float = 1.0
@export var turnDeccel : float = 4.0
@export var breakingTurnAccel : float = 2.0
@export var breakingTurnDeccel : float = 6.0
@export var turnNeutral : float = 0.15

@export var sprite : Sprite2D
@export var particleEffectPivotPoint : Node2D

var forwardSpeed : float = 0
var turningSpeed : float = 0

func _ready() -> void:
	SignalBus.connect("reached_house", victory)
	#SignalBus.connect("broken_part", _break_part)

func victory():
	print("Your Win!")

#func _break_part(index : int):
	#print("part broken!", index)

func _input(event: InputEvent) -> void:
	pass

func rotating(delta: float):
	direction = direction.rotated(turningSpeed * delta)
	sprite.rotate(turningSpeed * delta)
	particleEffectPivotPoint.rotate(turningSpeed * delta)
	
# Decrease player health/warm if in storm or heater is off
var t := 0.0
var fog_tween: Tween
func _process(delta: float) -> void:
	t = delta * 0.025
	if inStorm or !CarStats.car_parts["heating"]:
		PlayerStats.health = lerp(PlayerStats.health, 0.0, t)
	else:
		PlayerStats.health = lerp(PlayerStats.health, 100.0, t)
	# if windshield just broke and player hasnt started clearing, fog it up
	if !CarStats.car_parts["windshield"] and !CarStats.clearing_windshield:
		if fog_tween: fog_tween.kill()
		var target = clamp(fog_reference.modulate.a + 0.05, 0.0, 1.0)
		fog_tween = create_tween()
		fog_tween.tween_property(fog_reference, "modulate:a", target, 0.1)

		
func _physics_process(delta: float) -> void:#
	# Check if player is breaking
	
	var activeMaxSpeed = 0.0
	var activeAccel = 0.0
	var activeDecel = 0.0
	var activeTurnAccel = 0.0
	var activeTurnDecel = 0.0

	if Input.is_action_pressed("brakes") or offroad:
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
	
	if Input.is_action_pressed("gas_pedal") and CarStats.car_parts["engine"]:
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
	
	if Input.is_action_pressed("turn_left") and CarStats.car_parts["wheel"]:
		turningSpeed = clampf((turningSpeed - (activeTurnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	elif Input.is_action_pressed("turn_right") and CarStats.car_parts["wheel"]:
		turningSpeed = clampf((turningSpeed + (activeTurnAccel * delta)), -maxTurnSpeed, maxTurnSpeed)
	elif !CarStats.car_parts["wheel"]:
		pass
	else:
		if turningSpeed < 0:
			turningSpeed = clampf((turningSpeed + (activeTurnDecel * delta)), -maxTurnSpeed, maxTurnSpeed)
		elif turningSpeed > 0:
			turningSpeed = clampf((turningSpeed - (activeTurnDecel * delta)), -maxTurnSpeed, maxTurnSpeed)
		if abs(turningSpeed) < turnNeutral:
			turningSpeed = 0
	
	# Lower Speed If Deccelarating
	
	if forwardSpeed > activeMaxSpeed:
		forwardSpeed = clampf(forwardSpeed - activeDecel, activeMaxSpeed, maxSpeed)
	
	if Input.is_action_just_pressed("brakes"):
		directionBeforeBreak = direction
	
	# Set velocity
	if !Input.is_action_pressed("brakes"):
		velocity = forwardSpeed * direction
	else:
		velocity = forwardSpeed * ((directionBeforeBreak + direction) / 2)
	
	# Call rotating function
	
	rotating(delta)
	var crashed = move_and_slide()
	if crashed:
		forwardSpeed *= crashSpeedMultiplier
	#print($Timer.time_left)
	#print(velocity)

func _on_timer_timeout() -> void:
	print("timer out!")
	CarStats.break_something()

func _on_level_area_2d_body_exited(body: Node2D) -> void:
	#print("car has left level area!")
	offroad = true

func _on_level_area_2d_body_entered(body: Node2D) -> void:
	#print("car has returned to level area!")
	offroad = false
