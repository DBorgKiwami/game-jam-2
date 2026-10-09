extends Node

func _ready() -> void:
	SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)

enum car_part {ENGINE, WHEEL, HEATING, RADIO, WINDSHIELD, AERIAL}
			  # 0,      1,       2,      3,       4,        5
var car_parts := {
	"engine" = true,
	"wheel" = true
	#"heating" = true,
	#"radio" = true,
	#"windshield" = true,
	#"aerial" = true
}

# called from player/car script when timer sets off
func break_something():
	var part_to_break = car_parts.keys().pick_random()
	# if not broken, break it
	if car_parts[part_to_break]: 
		car_parts[part_to_break] = false
		print("breaking ", part_to_break)
		SignalBus.broken_part.emit(car_parts.keys().find(part_to_break))
	# else if everything is broken, exit
	elif not true in car_parts.values(): return
	else: break_something()

# broken part signal received: update respective flag
func _break_part(index : int):
	print("updating car stats, index: ", index, car_parts.keys()[index])
	match index:
		car_part.ENGINE:
			car_parts["engine"] = false
		car_part.WHEEL:
			car_parts["wheel"] = false

# fixed part signal received: update respective flag
func _fix_part(index : int):
	print("fixed part!")
	match index:
		car_part.ENGINE:
			car_parts["engine"] = true
		car_part.WHEEL:
			car_parts["wheel"] = true
