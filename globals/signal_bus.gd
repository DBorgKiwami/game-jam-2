extends Node

signal broken_part(part_index: int)
signal part_repaired(part_index: int)
signal toolbar_button_pressed(part_index: int)
signal reached_house()
signal reached_drive_thru()
signal reached_grocery_store()

#func _process(delta: float) -> void:
	#broken_part.emit(1)
