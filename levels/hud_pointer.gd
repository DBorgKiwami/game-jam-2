extends Node2D

var camera
var viewportcenter
var origin
@export var distanceBeforeNeutralPoint = 2000.0
@export var waypointOrder = 0

@onready var reticle: AnimatedSprite2D = $AnimatedSprite2D

func _drive_thru_reached() -> void:
	if waypointOrder == 1:
		visible = true
	else:
		visible = false
	pass

func _grocery_store_reached() -> void:
	if waypointOrder == 2:
		visible = true
	else:
		visible = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if waypointOrder != 0:
		visible = false
	SignalBus.connect("reached_drive_thru", _drive_thru_reached)
	SignalBus.connect("reached_grocery_store", _grocery_store_reached)
	origin = global_position
	camera = get_viewport().get_camera_2d()
	viewportcenter = Vector2(get_viewport().size) / 2.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var functionalOrigin
	if !CarStats.car_parts["radio"]:
		functionalOrigin = Vector2(randf_range(-10000, 10000),randf_range(-10000, 10000))
	else:
		functionalOrigin = origin
	look_at(functionalOrigin)
	rotation += PI * 0.5
	#print(camera.global_position.distance_to(origin))
	if camera.global_position.distance_to(functionalOrigin) > distanceBeforeNeutralPoint:
		global_position = camera.global_position + (camera.global_position.direction_to(functionalOrigin) * viewportcenter)
	else:
		global_position = functionalOrigin
		rotation = PI
