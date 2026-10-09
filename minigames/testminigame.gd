extends Node2D

var counter = 0;

func _on_button_pressed() -> void:
	counter+=1;
	if counter == 10:
		SignalBus.emit_signal("part_repaired", 0)
		counter = 0;
