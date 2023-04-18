class_name Menu
extends Control

signal game_started

var screens = {
	"main": preload("res://ui/menu/MainMenu.tscn").instantiate(),
#	"options": preload("")
}

var current_screen: CanvasLayer


func _ready():
	load_screen("main")	


func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed:
		game_started.emit()
		queue_free()


func load_screen(screen_name: String):
	var _load = func(screen_name: String):
		current_screen = screens[screen_name]
		for location in get_children():
			remove_child(location)
		add_child(current_screen)
	_load.call_deferred(screen_name)

