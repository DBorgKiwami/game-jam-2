extends Node2D

@export var tempdial : Sprite2D
@export var fandial : Sprite2D


func _ready() -> void:
	pass
	#SignalBus.connect("broken_part", setup_break)

func setup_break() -> void:
	var whichToBreak = randi_range(1, 3)
	if whichToBreak == 1:
		tempdial.rotation_degrees = -90 + randf_range(-15,15)
	elif whichToBreak == 2:
		fandial.rotation_degrees = 90 + randf_range(-15,15)
	elif whichToBreak == 3:
		tempdial.rotation_degrees = -90 + randf_range(-15,15)
		fandial.rotation_degrees = 90 + randf_range(-15,15)
	pass

func _physics_process(delta: float) -> void:
	if tempdial.rotation_degrees > -57 and fandial.rotation_degrees < 57:
		SignalBus.emit_signal("part_repaired", 1)
		tempdial.has_mouse = false
		tempdial.beingClicked = false
		fandial.has_mouse = false
		fandial.beingClicked = false
		setup_break()
