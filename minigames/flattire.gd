extends Node2D
var pump_has_mouse := false
var beingClicked := false
var pressure := 30.0
@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var area_2d: Area2D = $PumpingLever/Area2D
@onready var pump_sprite: Sprite2D = $PumpingLever

var og_pump_y

func _ready() -> void:
	og_pump_y = pump_sprite.position.y

func _physics_process(delta: float) -> void:
	var rounded = roundf(pressure)
	label.text = "%s"%rounded
	# only pump/deflate if broken
	if visible and !CarStats.car_parts["wheel"]:
		# PUMPING IF ACTIVELY CLICKING
		if (Input.is_action_pressed("left_click") and pump_has_mouse) or beingClicked:
			beingClicked = true
			CarStats.clearing_windshield = true
			pressure = clampf(pressure+0.05, 20., 40.);
			pump_sprite.position.y = clampf(pump_sprite.position.y+.5, -90, 90)
			#print("pumpinggg", pressure)
		
		# DEFLATING IN ANY OTHER CASE
		else:
			pressure = clampf(pressure-0.05, 0., 40.);
			pump_sprite.position.y = clampf(pump_sprite.position.y-.5, -90, 90)
			#print("deflatingg", pressure)

		if Input.is_action_just_released("left_click"):
			beingClicked = false
		if 32. < pressure and pressure < 36.:
			#print("youre winning the pump game")
			if timer.is_stopped():
				timer.start()
				#print("Correct, Erect")
		else:
			timer.stop()

func _on_pump_area_2d_mouse_entered() -> void:
	print("ON pump")
	pump_has_mouse = true

func _on_pump_area_2d_mouse_exited() -> void:
	print("OFF pump")
	pump_has_mouse = false

func _on_timer_timeout() -> void:
	#print("Hi timer out! Ya won")
	SignalBus.emit_signal("part_repaired", CarStats.car_part.WHEEL)
