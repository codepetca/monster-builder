extends Node2D

signal score_updated(score: int)


@onready var mobSpawnTimer = $MobSpawnTimer
@onready var mob_spawner = $MobSpawner as MobSpawner
@onready var menu = $Menu as Menu
@onready var wanted_screen = $Screens/WantedScreen

var game_started: bool = false
var target_monster: Monster
var score: int = 0 : set = _set_score


func _set_score(val:int):
	score = val
	score_updated.emit(score)


func increase_score_by(val: int):
	self.score += val


func _on_mob_spawn_timer_timeout():
	var mob = mob_spawner.spawn()
	mob.monster_tapped.connect(_on_monster_tapped)


func _on_monster_tapped(monster: Monster):
	increase_score_by(10)
	monster.queue_free()


func _on_menu_game_started():
	if game_started:
		return
	game_started = true
	
	# show target monster
	target_monster = mob_spawner.spawn()
	wanted_screen.monster = target_monster
	wanted_screen.show()


func _on_wanted_screen_game_resumed():
	wanted_screen.hide()
	mobSpawnTimer.start()
