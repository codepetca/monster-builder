class_name Widget
extends Node2D


@onready var mob_detector = $MobDetector
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $MobDetector/CollisionShape2D

var is_toggleable := false
var is_on: bool = true
var _on_color := "9db8f351"
var _off_color := "25429051"


func _ready():
	_update_widget()


func toggle():
	is_on = not is_on
	_update_widget()


func _update_widget():
	sprite_2d.self_modulate = _on_color if is_on else _off_color


func _on_toggle_detector_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and is_toggleable:
		toggle()
