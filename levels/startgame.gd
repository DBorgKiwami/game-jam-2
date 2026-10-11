extends CanvasLayer
const TESTLEVEL = preload("uid://ccpandbhv4j6j")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		start()

func start():
	get_tree().change_scene_to_packed(TESTLEVEL)
