extends CanvasLayer

@onready var player_reference : Car = get_tree().get_first_node_in_group("player")
@onready var steering_wheel: TextureRect = $ToolbarAndWheel/SteeringWheel

func _ready() -> void:
	#SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)
	var buttons := $ToolbarAndWheel/Toolbar/BtnContainer.get_children()
	for i in range(buttons.size()):
		buttons[i].connect("pressed", _on_tool_pressed.bind(i))

func _on_tool_pressed(tool_index : int):
	close_all_tabs()
	var mg := $MinigameContainer.get_child(tool_index)
	mg.visible = true

func _process(delta: float) -> void:
	var half_pi = PI * 0.5
	var rotation = remap(player_reference.turningSpeed, -player_reference.maxTurnSpeed, player_reference.maxTurnSpeed, -half_pi, half_pi)
	steering_wheel.offset_transform_rotation = rotation

# fixed part signal received: disable respective button and minigame
func _fix_part(index : int):
	close_all_tabs()

# return btn closes current/all minigame panel(s)
func _on_return_pressed() -> void:
	print("close minigame!")
	close_all_tabs()

func close_all_tabs() -> void:
	for mg in $MinigameContainer.get_children():
		mg.visible = false

