extends Node2D

signal score_updated(score: int)
signal wanted_updated(monster: Monster)


@onready var mob_spawn_timer = $Game/MobSpawnTimer
@onready var mob_spawner = $Game/MobSpawner as MobSpawner
@onready var wanted_screen = $Screens/WantedScreen
@onready var hud = $HUD


var game_started: bool = false
var target_monster: Monster
var score: int = 0 : set = _set_score


func _set_score(val:int):
	score = val
	score_updated.emit(score)


func increase_score_by(val: int):
	self.score += val


func _on_monster_tapped(monster: Monster):
	if monster.equals(target_monster):
		increase_score_by(10)
	monster.queue_free()


func _on_mob_spawn_timer_timeout():
	var mob = mob_spawner.spawn()
	mob.monster_tapped.connect(_on_monster_tapped)


func _on_wanted_screen_game_resumed():
	mob_spawn_timer.start()
	hud.show()


func _on_main_menu_game_started():
	if game_started:
		return
	game_started = true
	
	target_monster = mob_spawner.spawn(false)
	wanted_updated.emit(target_monster)
	wanted_screen.show()
