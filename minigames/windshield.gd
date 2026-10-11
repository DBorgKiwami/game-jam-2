extends Node2D

@onready var l_wind_shield: Sprite2D = $"Windshield Interactibles/LWindShield"
@onready var r_wind_shield: Sprite2D = $"Windshield Interactibles/RWindShield"
@onready var fog_reference : ColorRect = get_tree().get_first_node_in_group("fog")

@export var l_shield_min_rot : int
@export var l_shield_max_rot : int
@export var r_shield_min_rot : int
@export var r_shield_max_rot : int
var wshield_has_mouse = false
var beingClicked = false
var fog_tween: Tween

func _ready() -> void:
	SignalBus.connect("broken_part", reset)

func reset(tool_idx : int) -> void:
	# reset if windshield is acc broken
	print("here")
	if !CarStats.car_parts["windshield"]:
		print("resetting")
		#if fog_tween: fog_tween.kill()
		#fog_reference.modulate.a = 1.0
		#var target = 1.0
		#fog_tween = create_tween()
		#fog_tween.tween_property(fog_reference, "modulate:a", target, 0.1)
		CarStats.clearing_windshield = false

func _on_area_2d_mouse_entered() -> void:
	wshield_has_mouse = true
	#print("mouse in")

func _on_area_2d_mouse_exited() -> void:
	wshield_has_mouse = false
	#print("mouse out")

func _physics_process(delta: float) -> void:
	if visible:
		if (Input.is_action_pressed("left_click") and wshield_has_mouse) or beingClicked:
			beingClicked = true
			CarStats.clearing_windshield = true
			l_wind_shield.rotation_degrees += (Input.get_last_mouse_velocity().x)/100
			l_wind_shield.rotation_degrees = clamp(l_wind_shield.rotation_degrees, l_shield_min_rot, l_shield_max_rot)
			r_wind_shield.rotation_degrees += (Input.get_last_mouse_velocity().x)/100
			r_wind_shield.rotation_degrees = clamp(r_wind_shield.rotation_degrees, r_shield_min_rot, r_shield_max_rot)
		if Input.is_action_just_released("left_click"):
			beingClicked = false

func _on_fog_area_2d_entered(area: Area2D) -> void:
	if visible and CarStats.clearing_windshield:
		if fog_tween: fog_tween.kill()
		var target = fog_reference.modulate.a - 0.05
		fog_tween = create_tween()
		fog_tween.tween_property(fog_reference, "modulate:a", target, 0.1)
		print("clearing fog ", target)
		if target <= 0:
			SignalBus.part_repaired.emit(CarStats.car_part.WINDSHIELD)
