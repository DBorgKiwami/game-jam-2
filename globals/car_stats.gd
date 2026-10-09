extends Node
enum car_part {ENGINE, WHEEL, HEATING, RADIO, WINDSHIELD, AERIAL}

func _ready() -> void:
	SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)

var engine : bool = true
var wheel : bool = true
var heating : bool = true
var radio : bool = true
var windshield : bool = true
var aerial : bool = true

# broken part signal received: update respective flag
func _break_part(index : int):
	print("updating car stats, index: ", index)
	print(car_part.ENGINE)
	match index:
		car_part.ENGINE:
			print("setting engine to false")
			engine = false

# fixed part signal received: update respective flag
func _fix_part(index : int):
	print("fixed part!")
	print(index, car_part.ENGINE)
	match index:
		car_part.ENGINE:
			print("setting engine to true")
			engine = true
