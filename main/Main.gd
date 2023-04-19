extends Node2D

signal score_updated(score: int)
signal wanted_updated(monster: Monster)


@onready var mob_spawn_timer = $Game/MobSpawnTimer
@onready var mob_spawner = $Game/MobSpawner as MobSpawner
@onready var wanted_screen = $Screens/WantedScreen
@onready var hud = $HUD

var held_object: Pickable = null
var game_started: bool = false
var target_monster: Monster
var score: int = 0 : set = _set_score


func _set_score(val:int):
	score = val
	score_updated.emit(score)


func increase_score_by(val: int):
	self.score += val

#
#func _on_monster_tapped(monster: Monster):
#	if monster.equals(target_monster):
#		increase_score_by(10)
#	monster.disable_mode = CollisionObject2D.DISABLE_MODE_MAKE_STATIC

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and not event.is_pressed():
		if held_object and not event.pressed:
			held_object.drop()
			held_object = null

#
#func _input(event: InputEvent) -> void:
#	print(event.as_text())


func _on_mob_spawn_timer_timeout():
	var mob = mob_spawner.spawn()
	mob.picked_up.connect(_on_pickable_picked_up)


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


func _on_pickable_picked_up(object: Pickable):
	if not held_object:
		held_object = object
		held_object.pickup()
		if held_object.equals(target_monster):
			increase_score_by(10)
	
