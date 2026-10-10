extends Node2D

var camera
var viewportcenter
var origin
@export var distanceBeforeNeutralPoint = 2000.0

@onready var reticle: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = global_position
	camera = get_viewport().get_camera_2d()
	viewportcenter = Vector2(get_viewport().size) / 2.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(origin)
	rotation += PI * 0.5
	#print(camera.global_position.distance_to(origin))
	if camera.global_position.distance_to(origin) > distanceBeforeNeutralPoint:
		global_position = camera.global_position + (camera.global_position.direction_to(origin) * viewportcenter)
	else:
		global_position = origin
		rotation = PI
