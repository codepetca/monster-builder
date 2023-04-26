extends Node2D

signal start_game

@onready var level_container = $Level
@onready var hud = $HUD
@onready var ui = $UI


var LevelComplete := preload("res://ui/screens/LevelComplete.tscn")
var MainMenu := preload("res://ui/screens/MainMenu.tscn")

var game_started: bool = false
var level: Level
#var level_number := 0
var levels: Array[PackedScene] = [
	preload("res://levels/Level00.tscn"),
	preload("res://levels/Level01.tscn"),
	preload("res://levels/Level02.tscn")
]


func _ready():
	Signals.start_game.connect(_on_start_game)
	Signals.pop_screen.connect(_on_level_complete_pop_screen)
	Signals.push_screen.connect(_on_push_screen)
	var main_menu = MainMenu.instantiate()
	ui.add_child(main_menu)


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
	load_level(levels[0])
	hud.show()


func _on_push_screen(screen: Screen):
	ui.add_child(screen)
	screen.show()


func _on_level_complete(score: int):
	remove_level()
	hud.hide()
	var screen = LevelComplete.instantiate()
	screen.score = score
	ui.add_child(screen)


func _on_level_complete_pop_screen():
	hud.show()
	load_level(levels[1])

