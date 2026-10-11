extends Node
const GAMEOVER = preload("uid://d00v1o3c4q48a")

var health := 100.0
var hasBeenToDriveThru = false
var hasBeenToGroceryStore = false

var minigame_completion := [
	"Fix the engine by pulling the ripcord three times with your mouse",
	"Fix the wheel by keeping your tire pressure between 32 and 36 for at least 2 seconds by holding down the lever",
	"Fix the heater by maxxing out any dials which aren't to the max.",
	"Fix the radio by adding the digits together, and turn the dial to the rightmost digit",
	"Clear the foggy windshield by moving the wipers up and down with your mouse"
]

var difficulty_settings := {
	# setting: [easy, med, hard]
	"shrink_speed": [5.0, 7.5, 10.0],
	"offroad_damage": [2.5, 5.0, 10.0],
	"wait_time": [35.0, 25.0, 10.0]
}

enum difficulty_modes {EASY, MEDIUM, HARD}
var difficulty := difficulty_modes.MEDIUM # default

func reset():
	health = 100.0
	hasBeenToDriveThru = false
	hasBeenToGroceryStore = false

func _process(delta: float) -> void:
	if health <= 1.0:
		call_deferred("gameover")

func gameover():
	get_tree().change_scene_to_packed(GAMEOVER)
