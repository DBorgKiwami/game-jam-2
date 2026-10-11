extends CanvasLayer

@onready var player_reference : Car = get_tree().get_first_node_in_group("player")
@onready var steering_wheel: TextureRect = $ToolbarAndWheel/SteeringWheel
var buttons
var buttonsIndicators = []
var timeElapsed = 0

func _on_break(index):
	print(index)
	print(buttonsIndicators)
	buttonsIndicators[index] = true
	#var i = 0
	#for part in CarStats.car_parts:
		#print(part)
		#print(CarStats.car_parts[part])
		#if !CarStats.car_parts[part]:
			#buttons[i].modulate = Color(255, 0, 0)
		#else:
			#buttons[i].modulate = Color(0, 0, 0)
		#i += 1
	pass

func _ready() -> void:
	#SignalBus.connect("broken_part", _break_part)
	SignalBus.connect("part_repaired", _fix_part)
	SignalBus.connect("broken_part", _on_break)
	buttons = $ToolbarAndWheel/Toolbar/BtnContainer.get_children()
	for i in range(buttons.size()):
		buttons[i].connect("pressed", _on_tool_pressed.bind(i))
		buttonsIndicators = buttonsIndicators + [false]

func _on_tool_pressed(tool_index : int):
	close_all_tabs()
	var mg := $MinigameContainer.get_child(tool_index)
	mg.visible = true

func _process(delta: float) -> void:
	timeElapsed += delta
	var half_pi = PI * 0.5
	var rotation = remap(player_reference.turningSpeed, -player_reference.maxTurnSpeed, player_reference.maxTurnSpeed, -half_pi, half_pi)
	steering_wheel.offset_transform_rotation = rotation
	
	#print(timeElapsed)
	
	for i in range(buttons.size()):
		if buttonsIndicators[i]:
			#print(1.0 * wrapf(timeElapsed, 0.0, 1.0))
			buttons[i].modulate.r = 1.0 * wrapf(timeElapsed, 0.0, 1.0)

# fixed part signal received: disable respective button and minigame
func _fix_part(index : int):
	close_all_tabs()
	buttons[index].modulate = Color(0, 0, 0)
	buttonsIndicators[index] = false

# return btn closes current/all minigame panel(s)
func _on_return_pressed() -> void:
	print("close minigame!")
	close_all_tabs()

func close_all_tabs() -> void:
	for mg in $MinigameContainer.get_children():
		mg.visible = false
