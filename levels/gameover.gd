extends CanvasLayer
const TESTLEVEL = preload("uid://ccpandbhv4j6j")
const STARTGAME = preload("uid://vsj5pvmyjnb0")

func _on_restart_button_pressed() -> void:
	#print("heyyyy")
	##print(PlayerStats.health)
	#print("resetted car and player stats now changing back to level")
	get_tree().change_scene_to_packed(STARTGAME)

func _ready() -> void:
	CarStats.reset()
	PlayerStats.reset()
