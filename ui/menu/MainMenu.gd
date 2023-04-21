class_name MainMenu
extends Control

signal start_game


@onready var texture_rect = $TextureRect
@onready var title_label = $CenterContainer/VBoxContainer/TitleLabel
@onready var subtitle_label = $CenterContainer/VBoxContainer/SubtitleLabel


func show_message(text: String, delay: int = 2):
	texture_rect.text = text
	await get_tree().create_timer(delay).timeout
	title_label.text = ""
	subtitle_label.text = ""


func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		start_game.emit()
		queue_free()
