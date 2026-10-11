extends Node2D

@onready var area = $"House Area"
@onready var timer = $Timer
@onready var progressBar = $ProgressBar
const FINALSCENE = preload("uid://c3fxh2uaegfe6")

func _ready() -> void:
	$Label.visible = false
	pass

func _physics_process(delta: float) -> void:
	if !timer.is_stopped():
		progressBar.value = 5.0 - timer.time_left

func _on_house_area_body_entered(body: Node2D) -> void:
	if body is Car:
		timer.start()
	pass # Replace with function body.

func _on_house_area_body_exited(body: Node2D) -> void:
	if body is Car:
		timer.stop()
		progressBar.value = 0.0
		$Label.visible = false
	pass # Replace with function body.

func _on_timer_timeout() -> void:
	if PlayerStats.hasBeenToDriveThru and PlayerStats.hasBeenToGroceryStore:
		SignalBus.emit_signal("reached_house")
		get_tree().change_scene_to_packed(FINALSCENE)
	else:
		print("bitch")
		$Label.visible = true
	pass # Replace with function body.
