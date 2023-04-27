class_name Widget
extends Node2D

enum ACTION { change_costume, teleport }
var action: ACTION = ACTION.change_costume


@onready var mob_detector = $MobDetector
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $MobDetector/CollisionShape2D
@onready var portal = $Portal

var target_monster: Monster
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


func _on_mob_detector_body_entered(mob):
	if not mob is Monster:
		return
	# Don't detect a mob that is already picked up		
	if mob.selected: 
		return		
	if not is_on:
		return
	mob.pickable = false	
	match action:
		ACTION.change_costume:
			change_costume(mob)
		ACTION.teleport:
			teleport(mob)


func _on_mob_detector_body_exited(mob):
	if mob is Monster:
		mob.pickable = true
		mob.velocity = mob.normal_velocity
#		widget_action.emit(mob, ACTION.exited)


func change_costume(mob: Monster):	
	mob.velocity = mob.BASE_VELOCITY
	if mob.costume.equals(target_monster.costume):
		mob.change_costume_animated()
	else:
		mob.change_costume_animated(target_monster.costume)


func teleport(mob: Monster):
	mob.velocity = Vector2.ZERO
	portal.send(mob.costume.to_json())
	mob.dead()

