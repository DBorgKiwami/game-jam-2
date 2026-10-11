extends Area2D

@export var shrinkSpeed = 7.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shrinkSpeed = PlayerStats.difficulty_settings["shrink_speed"][PlayerStats.difficulty]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	scale -= (Vector2.ONE * shrinkSpeed) * delta
	scale = clamp(Vector2(50, 50), scale, Vector2 (2000, 2000))
	#print(scale)

func _on_body_exited(body: Node2D) -> void:
	if body is Car:
		body.inStorm = true
		print("Out")
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body is Car:
		body.inStorm = false
		print("In")
	pass # Replace with function body.
