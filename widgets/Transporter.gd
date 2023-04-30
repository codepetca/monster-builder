class_name Transporter
extends Node2D


@onready var mob_detector = $MobDetector
@onready var sprite_2d = $Sprite2D
@onready var portal = $Portal

var max_seats := 1
var occupied_seats := 0

var seats_are_full : bool :
	get:
		return occupied_seats == max_seats

var is_toggleable := false
var is_on: bool = true
var _on_color := "9db8f351"
var _off_color := "25429051"


func _ready():
	Signals.pickable_dropped.connect(_on_pickable_dropped)
	_update_widget()


func _transporter_entered(mob: Monster):
	if seats_are_full:
		mob.random_move()
		mob.pickable = true
	else:
		mob.pickable = false		
		occupied_seats += 1
		_transport(mob)


func _transport(mob: Monster):
	mob.velocity = Vector2.ZERO
	var on_animation_finished = func():
		portal.send(mob.costume.to_json())
		occupied_seats = 0
	mob.dead(on_animation_finished)


func toggle():
	is_on = not is_on
	_update_widget()


func _update_widget():
	sprite_2d.self_modulate = _on_color if is_on else _off_color


## Check if the pickable was dropped on this widget
func _on_pickable_dropped(mob: Monster):
	for body in mob_detector.get_overlapping_bodies():
		if body == mob:
			_transporter_entered(mob)


func _on_toggle_detector_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and is_toggleable:
		toggle()


func _on_mob_detector_body_entered(mob):
	if not mob is Monster: return
	if mob.selected: return  # Try removing this and setting collisiion layer
	if not is_on: return
	_transporter_entered(mob)



