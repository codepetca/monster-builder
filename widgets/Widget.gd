class_name Widget
extends Node2D

enum ACTION { change_costume, teleport }
var action: ACTION = ACTION.change_costume


@onready var mob_detector = $MobDetector
@onready var sprite_2d = $Sprite2D
@onready var portal = $Portal

var target_costume: Costume
var is_toggleable := false
var is_on: bool = true
var _on_color := "9db8f351"
var _off_color := "25429051"


func _ready():
	Signals.pickable_dropped.connect(_on_pickable_dropped)
	_update_widget()


func check_inside_area():
	for body in mob_detector.get_overlapping_bodies():
		if body is Monster:
			print("Monster is inside the target area")
			emit_signal("monster_in_area") # You can create and connect this signal to any function
			break


func toggle():
	is_on = not is_on
	_update_widget()


func _update_widget():
	sprite_2d.self_modulate = _on_color if is_on else _off_color


func _on_toggle_detector_input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and is_toggleable:
		toggle()


func _on_mob_detector_body_entered(mob):
	if not mob is Monster: return
	if mob.selected: return  # Try removing this and setting collisiion layer
	if not is_on: return
	_perform_action(mob)


func _on_mob_detector_body_exited(mob):
	if mob is Monster:
		mob.pickable = true
		mob.velocity = mob.normal_velocity
#		widget_action.emit(mob, ACTION.exited)


## Check if the pickable was dropped on this widget
func _on_pickable_dropped(mob: Monster):
	for body in mob_detector.get_overlapping_bodies():
		if body == mob:
			_perform_action(mob)


func _perform_action(mob: Monster):
	mob.pickable = false	
	match action:
		ACTION.change_costume:
			_change_costume(mob)
		ACTION.teleport:
			_teleport(mob)


func _change_costume(mob: Monster):	
	mob.velocity = mob.BASE_VELOCITY
	if mob.costume.equals(target_costume):
		mob.change_costume_animated()
	else:
		mob.change_costume_animated(target_costume)


func _teleport(mob: Monster):
	mob.velocity = Vector2.ZERO
	var on_animation_finished = func(): portal.send(mob.costume.to_json())
	mob.dead(on_animation_finished)
	

