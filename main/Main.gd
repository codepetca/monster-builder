extends Node2D

signal start_game

@onready var level_container = $Level
@onready var hud = $HUD
@onready var main_menu = $Screens/MainMenu


var held_object: Pickable = null
var game_started: bool = false
var mob_spawn_timer: Timer
var mob_spawner: MobSpawner
var level: Level
var levels: Array[PackedScene] = [
	preload("res://levels/Level00.tscn"),
	preload("res://levels/Level01.tscn"),
	preload("res://levels/Level02.tscn")
]


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


func load_level(LevelScene: PackedScene):
	if level:
		level_container.remove_child(level)
		level.queue_free()
	level = LevelScene.instantiate() as Level
	level_container.add_child(level, true)
	mob_spawner = level.get_node("MobSpawner") as MobSpawner
	mob_spawn_timer= level.get_node("MobSpawnTimer") as Timer
	mob_spawn_timer.timeout.connect(_on_mob_spawn_timer_timeout)
	level.score_updated.connect(hud._on_score_updated)
	level.level_complete.connect(_on_level_complete)
	mob_spawn_timer.start()


func _on_start_game():
	if game_started:
		return
	game_started = true
	hud.show()
	load_level(levels[1])


func _on_level_complete():
	get_tree().paused = true
	print("level complete")
	await get_tree().create_timer(2).timeout
	
	load_level(levels[1])
	get_tree().paused = false
