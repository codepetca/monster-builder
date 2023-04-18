class_name WantedScreen
extends CanvasLayer

signal game_resumed(monster: Monster)


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


func _input(event):
	
	if event is InputEventScreenTouch and event.pressed:
		await get_tree().create_timer(2).timeout
		label.text = ""
		if monster:
			monster.hide()
		game_resumed.emit(monster)
		self.hide()

