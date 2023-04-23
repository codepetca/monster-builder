class_name Widget
extends Node2D


@onready var mob_detector = $MobDetector
@onready var sprite_2d = $Sprite2D


var _is_on: bool = true
var _on_hex := "9db8f351"
var _off_hex := "25429051"


func _ready():
	_update_appearance()


func toggle():
	_is_on = not _is_on
	_update_appearance()


func _update_appearance():
	sprite_2d.self_modulate = _on_hex if _is_on else _off_hex



func _on_mob_detector_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		toggle()
