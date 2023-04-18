class_name WantedScreen
extends CanvasLayer

signal game_resumed


@onready var label = $VBoxContainer/Label
@onready var texture_rect = $VBoxContainer/TextureRect


var monster: Monster = null : set = _set_monster, get = _get_monster


func _set_monster(val: Monster):
	monster = val
	monster.velocity = Vector2.ZERO
	monster.position = get_viewport().size/2
	monster.rotation = 0
	monster.reparent(self)


func _get_monster(): return monster


func clear():
	label.text = ""
	if monster:
		print("monster")
		monster.dead()


func _unhandled_input(event):
	if event.is_action_released("ui_accept"):
#		clear()
		game_resumed.emit()

