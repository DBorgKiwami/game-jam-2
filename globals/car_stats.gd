extends Node

func _ready() -> void:
	SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)

enum car_part {ENGINE, WHEEL, HEATING, RADIO, WINDSHIELD, AERIAL}
			  # 0,      1,       2,      3,       4,        5
var car_parts := {
	"engine" = true, # breaks accel
	"wheel" = true, # breaks turning
	"heating" = true, # decr. health
	"radio" = true, # breaks waypoint
	"windshield" = true # fogs screen
	#"aerial" = true
}

var clearing_windshield := false

# called from player/car script when timer sets off
func break_something():
	#var part_to_break = car_parts.keys()[4] # HARDCODE
	
	# check from parts still intact
	var intact = car_parts.keys().filter(func(p): return car_parts[p])
	# if all broken, just return
	if intact.is_empty(): 
		print("everything is broken. nothing to break")
		return
	var part_to_break = intact.pick_random()
	car_parts[part_to_break] = false
	SignalBus.broken_part.emit(car_parts.keys().find(part_to_break))

# broken part signal received: update respective flag
func _break_part(index : int):
	var part = car_parts.keys()[index]
	car_parts[part] = false
	print("broken ", part, "! index: ", index, ": ", car_parts.keys()[index])

# fixed part signal received: update respective flag
func _fix_part(index : int):
	var part = car_parts.keys()[index]
	car_parts[part] = true
	print("fixed ", part, "! index: ", index, ": ", car_parts.keys()[index])
