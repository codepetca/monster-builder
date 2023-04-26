extends Node2D

signal start_game

@onready var level_container = $Level
@onready var hud = $HUD
@onready var main_menu = $Screens/MainMenu


var game_started: bool = false
var level: Level
var levels: Array[PackedScene] = [
	preload("res://levels/Level00.tscn"),
	preload("res://levels/Level01.tscn"),
#	preload("res://levels/Level02.tscn")
]


func load_level(LevelScene: PackedScene):
	if level:
		level_container.remove_child(level)
		level.queue_free()
	level = LevelScene.instantiate() as Level
	level_container.add_child(level, true)
	level.score_updated.connect(hud._on_score_updated)
	level.level_complete.connect(_on_level_complete)
	level.start()


func _on_start_game():
	if game_started:
		return
	game_started = true
	hud.show()
	load_level(levels[0])


func _on_level_complete():
	get_tree().paused = true
	print("level complete")
	await get_tree().create_timer(2).timeout
	
	load_level(levels[1])
	get_tree().paused = false
