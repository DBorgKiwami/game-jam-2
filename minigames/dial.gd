extends Sprite2D

var has_mouse = false
var active = true
var beingClicked = false

func _on_area_2d_mouse_entered() -> void:
	has_mouse = true
	pass # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	has_mouse = false
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("left_click") and has_mouse) or beingClicked:
		beingClicked = true
		rotation_degrees -= (Input.get_last_mouse_velocity().y)/100
		rotation_degrees = clampf(rotation_degrees, -122, -45)
	if Input.is_action_just_released("left_click"):
		beingClicked = false
	
	if rotation_degrees > -57:
		SignalBus.emit_signal("part_repaired", 1)
		rotation_degrees = -90
