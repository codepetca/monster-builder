class_name WantedScreen
extends Control

signal game_resumed()


@onready var label = $CenterContainer/VBoxContainer/Label
@onready var center_container = $CenterContainer/VBoxContainer/CenterContainer


var monster: Monster = null : set = _set_monster

func _set_monster(wanted: Monster):
	for texture_filename in wanted.texture_filenames:
		var texture_rect = TextureRect.new()
		center_container.add_child(texture_rect)
		texture_rect.texture = load(texture_filename)


func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		await get_tree().create_timer(2).timeout
		game_resumed.emit()
		queue_free()

