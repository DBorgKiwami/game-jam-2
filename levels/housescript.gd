extends Node2D

@onready var area = $"House Area"
@onready var timer = $Timer
@onready var progressBar = $ProgressBar

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if !timer.is_stopped():
		print("AAAAAAAAAAAA")
		progressBar.value = 5.0 - timer.time_left

func _on_house_area_body_entered(body: Node2D) -> void:
	timer.start()
	pass # Replace with function body.

func _on_house_area_body_exited(body: Node2D) -> void:
	timer.stop()
	progressBar.value = 0.0
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	SignalBus.emit_signal("reached_house")
	pass # Replace with function body.
