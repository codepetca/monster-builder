extends Screen


@onready var texture_rect = $TextureRect
@onready var title_label = $CenterContainer/VBoxContainer/TitleLabel
@onready var play = $CenterContainer/VBoxContainer/Play
@onready var options = $CenterContainer/VBoxContainer/Options


func _on_play_pressed():
	Signals.start_game.emit()
	queue_free()


func _on_options_pressed():
	pass # Replace with function body.
