extends Node2D

@onready var ripcord : Node2D = $Ripcord
@onready var startingPoint : Node2D = $"Ripcord Hole/Start Point"
@onready var endingPoint : Node2D = $"Ripcord/End Point"
@onready var line : Line2D = $Cord
@onready var lightIndicators : Node2D = $"Light Indicators"

@export var retractSpeed : float = 1.0
@export var requiredDistance : float = 500.0

var ripcordOrigin
var rips = 0

var ripcordHasMouse = false
var beingClicked = false


func _ready() -> void:
	ripcordOrigin = ripcord.position
	line.add_point(startingPoint.global_position)
	line.add_point(endingPoint.global_position)

func _physics_process(delta: float) -> void:
	line.set_point_position(1, endingPoint.global_position)
	if (Input.is_action_pressed("left_click") and ripcordHasMouse) or beingClicked:
		beingClicked = true
		ripcord.position = get_local_mouse_position()
		ripcord.rotation = (get_local_mouse_position().y)/1000
		#dialSprite.rotation_degrees += (Input.get_last_mouse_velocity().x)/100
		#turnDistance += (Input.get_last_mouse_velocity().x)/100
	if Input.is_action_just_released("left_click"):
		if ripcord.position.distance_to(ripcordOrigin) > requiredDistance and beingClicked:
			#print("Ripped")
			#print(ripcord.position.distance_to(ripcordOrigin))
			ripped()
		else:
			$Bad.playing = true
		beingClicked = false
		ripcord.rotation = 0
	if !beingClicked:
		ripcord.position = ripcord.position.lerp(ripcordOrigin, delta * retractSpeed)

func ripped():
	$Good.playing = true
	rips = rips + 1
	for i in range(rips % 3):
		lightIndicators.get_child(i).modulate = Color(0,255,0)
	if rips >= 3:
		SignalBus.emit_signal("part_repaired", CarStats.car_part.ENGINE)
		ripcord.position = ripcordOrigin
		for child in lightIndicators.get_children():
			child.modulate = Color(255,0,0)
		rips = 0

func _on_area_2d_mouse_entered() -> void:
	ripcordHasMouse = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	ripcordHasMouse = false
	pass # Replace with function body.
