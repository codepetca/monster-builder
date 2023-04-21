class_name WantedScreen
extends Control

signal game_resumed


@onready var label = $CenterContainer/VBoxContainer/Label
@onready var center_container = $CenterContainer/VBoxContainer/CenterContainer


func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		await get_tree().create_timer(2).timeout
#		game_resumed.emit()
		queue_free()


func _on_main_wanted_updated(monster: Monster):
	for texture_filename in monster.texture_filenames:
		var texture_rect = TextureRect.new()
		center_container.add_child(texture_rect)
		texture_rect.texture = load(texture_filename)
