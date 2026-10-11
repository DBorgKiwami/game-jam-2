extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spriteIndex = randi_range(1, 6)
	var flipH = randi_range(0,1)
	if flipH == 1:
		flip_h = true
	texture = load("res://images/tree" + str(spriteIndex) + ".png")
	pass # Replace with function body.
