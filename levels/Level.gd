class_name Level
extends Node2D


var held_object: Pickable = null
var mob_spawner: MobSpawner


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and not event.is_pressed():
		if held_object and is_instance_valid(held_object) and not event.pressed:
			held_object.drop()
			held_object = null


func _on_pickable_picked_up(object: Pickable):
	if not held_object:
		held_object = object
		held_object.pickup()


func _on_mob_spawn_timer_timeout():
	var mob = mob_spawner.spawn()
	mob.picked_up.connect(_on_pickable_picked_up)
