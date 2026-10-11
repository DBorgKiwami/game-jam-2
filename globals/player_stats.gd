extends Node

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

func _ready() -> void:
	pass # Replace with function body.

#func _process(delta: float) -> void:
	#print("health ", roundf(health))
