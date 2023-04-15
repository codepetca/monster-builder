extends Node2D

var game_started: bool = false


@onready var mobSpawnTimer = $MobSpawnTimer
@onready var mob_spawner = $MobSpawner as MobSpawner
@onready var ui_screen = $UIScreen as UIScreen

var all_spawns: Array[Monster] = []


func spawn_mob():
	var mob = mob_spawner.spawn()
	add_child(mob)
	all_spawns.append(mob.duplicate())
	if all_spawns.size() > 1:
		print(all_spawns[0].equals(mob))


func _on_mob_spawn_timer_timeout():
	spawn_mob()


func _on_ui_screen_game_started():
	if game_started:
		return
	ui_screen.show_message("Get ready...")
	game_started = true
	await get_tree().create_timer(1).timeout
	mobSpawnTimer.start()
