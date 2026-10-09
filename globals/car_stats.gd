extends Node
enum car_part {ENGINE, WHEEL, HEATING, RADIO, WINDSHIELD, AERIAL}

func _ready() -> void:
	SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)

var car_parts := {
	"engine" = true
	#"wheel" = true,
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
		print("breaking", part_to_break)
		SignalBus.broken_part.emit(car_parts.keys().find(part_to_break))
	# else if everything is broken, exit
	elif not true in car_parts.values(): return
	else: break_something()

# broken part signal received: update respective flag
func _break_part(index : int):
	print("updating car stats, index: ", index)
	print(car_part.ENGINE)
	match index:
		car_part.ENGINE:
			print("setting engine to false")
			car_parts["engine"] = false

# fixed part signal received: update respective flag
func _fix_part(index : int):
	print("fixed part!")
	print(index, car_part.ENGINE)
	match index:
		car_part.ENGINE:
			print("setting engine to true")
			car_parts["engine"] = true
