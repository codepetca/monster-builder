extends Node2D

signal start_game


@onready var mob_spawn_timer = $Level_01/MobSpawnTimer
@onready var mob_spawner = $Level_01/MobSpawner as MobSpawner
@onready var hud = $HUD
@onready var level_01 = $Level_01


var held_object: Pickable = null
var game_started: bool = false


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


func _on_main_menu_start_game():
	if game_started:
		return
	game_started = true
	
	hud.show()
	level_01.set_targets()
	mob_spawn_timer.start()


func _on_multiplayer_start_game():
	if game_started:
		return
	game_started = true
	
	hud.show()
	level_01.set_targets()
	mob_spawn_timer.start()


func _on_level_01_level_complete():
	get_tree().paused = true
	print("level complete")
