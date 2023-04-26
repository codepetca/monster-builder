extends Node2D

signal start_game

@onready var level_container = $Level
@onready var hud = $HUD
@onready var ui = $UI
@onready var main_menu = $UI/MainMenu


var LevelComplete := preload("res://ui/screens/LevelCompleteScreen.tscn")
var MainMenu := preload("res://ui/menu/MainMenu.tscn")

var game_started: bool = false
var level: Level
#var level_number := 0
var levels: Array[PackedScene] = [
	preload("res://levels/Level00.tscn"),
	preload("res://levels/Level01.tscn"),
	preload("res://levels/Level02.tscn")
]


func load_level(LevelScene: PackedScene):
	level = LevelScene.instantiate() as Level
	level_container.add_child(level, true)
	level.score_updated.connect(hud._on_score_updated)
	level.level_complete.connect(_on_level_complete)
	level.start()


func remove_level():
	if level:
		level_container.remove_child(level)
		level.queue_free()


func _on_start_game():
	if game_started:
		return
	game_started = true
	hud.show()
	load_level(levels[0])


func _on_level_complete(score: int):
	remove_level()
	hud.hide()
	var screen = LevelComplete.instantiate()
	screen.score = score
	ui.add_child(screen)
	
	Signals.pop_screen.connect(_on_level_complete_pop_screen)


func _on_level_complete_pop_screen():
	hud.show()
	load_level(levels[1])

