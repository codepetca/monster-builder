class_name MainMenu
extends CanvasLayer

signal game_started

@onready var label = $Label
@onready var texture_rect = $TextureRect


func show_message(text: String, delay: int = 2):
	label.text = text
	await get_tree().create_timer(delay).timeout
	label.text = ""

#
#func _unhandled_input(event):
#	if event.is_action_pressed("ui_accept"):
#		game_started.emit()
#
#
