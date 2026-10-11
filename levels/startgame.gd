extends CanvasLayer
const TESTLEVEL = preload("uid://ccpandbhv4j6j")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_pressed("left_click"):
		#start()

func start():
	get_tree().change_scene_to_packed(TESTLEVEL)

func _on_option_button_item_selected(index: int) -> void:
	PlayerStats.difficulty = index
	print("changing difficulty!")
	print(PlayerStats.difficulty_settings["shrink_speed"][PlayerStats.difficulty])
	print(PlayerStats.difficulty_settings["wait_time"][PlayerStats.difficulty])
	print(PlayerStats.difficulty_settings["offroad_damage"][PlayerStats.difficulty])
