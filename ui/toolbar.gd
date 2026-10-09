extends CanvasLayer

func _ready() -> void:
	#SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)

# broken part signal received: enable respective button
#func _break_part(index : int):
	#match index:
		#CarStats.engine:
			#pass
			#print("engine broken!")

# fixed part signal received: disable respective button and minigame
func _fix_part(index : int):
	close_all_tabs()

# tool 1 enables minigame 1 panel
func _on_tool_1_pressed() -> void:
	$MinigameContainer/Testminigame.visible = true

# return btn closes current/all minigame panel(s)
func _on_return_pressed() -> void:
	print("close minigame!")
	close_all_tabs()

func close_all_tabs() -> void:
	for mg in $MinigameContainer.get_children():
		mg.visible = false


func _on_tool_2_pressed() -> void:
	$MinigameContainer/Heater.visible = true
	pass # Replace with function body.
