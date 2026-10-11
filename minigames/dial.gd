extends Sprite2D

var has_mouse = false
var active = true
var beingClicked = false

@export var flip_rotation = false
@export var upperBound = -45
@export var lowerBound = -122

func _on_area_2d_mouse_entered() -> void:
	has_mouse = true
	pass # Replace with function body.

func _on_area_2d_mouse_exited() -> void:
	has_mouse = false
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if (Input.is_action_pressed("left_click") and has_mouse) or beingClicked:
		beingClicked = true
		if !flip_rotation:
			rotation_degrees -= (Input.get_last_mouse_velocity().y)/100
		else:
			rotation_degrees += (Input.get_last_mouse_velocity().y)/100
		rotation_degrees = clampf(rotation_degrees, lowerBound, upperBound)
	if Input.is_action_just_released("left_click"):
		beingClicked = false
