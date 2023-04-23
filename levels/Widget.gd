extends Node2D

@onready var tap_detector = $TapDetector
@onready var mob_detector = $MobDetector


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		pass
