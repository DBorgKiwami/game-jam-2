extends Node2D

var dialHasMouse = false
var beingClicked = false
var number1 = 1
var number2 = 9
var inputNumber = 2
var turnDistance = 0
var minus = false
@onready var dialSprite = $"Radio Interactibles/Radio Dial"
@onready var label = $Label
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	dialHasMouse = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	dialHasMouse = false
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if visible:
		if (Input.is_action_pressed("left_click") and dialHasMouse) or beingClicked:
			beingClicked = true
			dialSprite.rotation_degrees += (Input.get_last_mouse_velocity().x)/100
			turnDistance += (Input.get_last_mouse_velocity().x)/100
		if Input.is_action_just_released("left_click"):
			beingClicked = false
		#print(inputNumber)
		if turnDistance > 10:
			inputNumber = wrap(inputNumber + 1, 0, 10)
			turnDistance = 0
		if turnDistance < -10:
			inputNumber = wrap(inputNumber - 1, 0, 10)
			turnDistance = 0
		label.text = str(number1) + str(number2) + "." + str(inputNumber)
		if !minus:
			label.text = str(number1) + str(number2) + "." + str(inputNumber) + " AM"
			if wrap(number1 + number2, 0, 10) == inputNumber:
				if timer.is_stopped():
					timer.start()
				#print("Correct, Erect")
			else:
				timer.stop()
		else:
			label.text = str(number1) + str(number2) + "." + str(inputNumber) + " FM"
			if wrap(number1 - number2, 0, 10) == inputNumber:
				if timer.is_stopped():
					timer.start()
			else:
				timer.stop()


func _on_timer_timeout() -> void:
	print("Hi")
	SignalBus.emit_signal("part_repaired", 2)
	number1 = randi_range(1,9)
	number2 = randi_range(0,9)
	inputNumber = randi_range(0,9)
	pass # Replace with function body.
