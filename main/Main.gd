extends Node2D

signal start_game
signal score_updated(score: int)
signal wanted_updated(monster: Monster)


@onready var mob_spawn_timer = $Level1/MobSpawnTimer
@onready var mob_spawner = $Level1/MobSpawner as MobSpawner
@onready var wanted_screen = $Screens/WantedScreen
@onready var hud = $HUD
@onready var level_1 = $Level1


var held_object: Pickable = null
var game_started: bool = false
var target_monster: Monster
var score: int = 0 : set = _set_score


func _set_score(val:int):
	score = val
	score_updated.emit(score)


func increase_score_by(val: int):
	self.score += val


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and not event.is_pressed():
		if held_object and not event.pressed:
			held_object.drop()
			held_object = null


func _on_mob_spawn_timer_timeout():
	var mob = mob_spawner.spawn()
	mob.picked_up.connect(_on_pickable_picked_up)

#
#func _on_wanted_screen_game_resumed():
#	mob_spawn_timer.start()
#	hud.show()

func _on_main_menu_start_game():
	if game_started:
		return
	game_started = true
	
	hud.show()
	level_1.set_targets()
	mob_spawn_timer.start()


func _on_pickable_picked_up(object: Pickable):
	if not held_object:
		held_object = object
		held_object.pickup()
		increase_score_by(10)





