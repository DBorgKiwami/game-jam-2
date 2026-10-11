extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spriteIndex = randi_range(1, 4)
	texture = load("res://images/roadsign" + str(spriteIndex) + ".png")
	pass # Replace with function body.
