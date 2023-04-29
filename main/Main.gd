extends Node2D

signal start_game

@onready var level_container = $Level
@onready var hud = $HUD as HUD
@onready var ui = $UI as UI


var LevelCompleteScreen := preload("res://ui/screens/LevelComplete.tscn")
var MainMenu := preload("res://ui/screens/MainMenu.tscn")


var game_started: bool = false
var level: Level
#var level_number := 0
var levels: Array[PackedScene] = [
	preload("res://levels/Level00.tscn"),
]


func _ready():
	Signals.start_game.connect(_on_start_game)
	Signals.pop_screen.connect(_on_pop_screen)
	Signals.push_screen.connect(_on_push_screen)

	Signals.push_screen.emit(MainMenu.instantiate())


func load_level(LevelScene: PackedScene):
	level = LevelScene.instantiate() as Level
	level_container.add_child(level, true)
	Signals.level_complete.connect(_on_level_complete)
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
	for child in ui.get_children():
		child.hide()
	ui.add_child(screen)
	screen.show()


func _on_pop_screen():
	if ui.get_child_count() == 0:
		# if no screen in the UI, load the next level
		hud.show()
		load_level(levels[0])
	else:
		# unhide the last child
		ui.get_children()[0].show()


func _on_level_complete(score: int):
	_broadcast_on_level_complete.rpc(score)

@rpc("any_peer", "call_local")
func _broadcast_on_level_complete(score: int):
	remove_level()
	hud.hide()
	var screen = LevelCompleteScreen.instantiate()
	screen.score = score
	Signals.push_screen.emit(LevelCompleteScreen.instantiate())


