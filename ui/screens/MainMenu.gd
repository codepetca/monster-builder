extends Screen


@onready var texture_rect = $TextureRect
@onready var title_label = $CenterContainer/VBoxContainer/TitleLabel
@onready var play = $CenterContainer/VBoxContainer/Play
@onready var options = $CenterContainer/VBoxContainer/Options

var Multiplayer := preload("res://ui/multiplayer/Multiplayer.tscn")
var Options := preload("res://ui/screens/Options.tscn")


func _on_play_pressed():	
	Signals.push_screen.emit(Multiplayer.instantiate())


func _on_options_pressed():
	Signals.push_screen.emit(Options.instantiate())
