class_name MainMenu
extends Control

signal game_started

@onready var texture_rect = $TextureRect
@onready var label = $Label


func show_message(text: String, delay: int = 2):
	label.text = text
	await get_tree().create_timer(delay).timeout
	label.text = ""


func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		game_started.emit()
		queue_free()
