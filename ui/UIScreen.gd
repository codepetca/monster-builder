class_name UIScreen
extends CanvasLayer

signal game_started

@onready var label = $Label
@onready var texture_rect = $TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func show_message(text: String, delay: int = 2):
	label.text = text
	await get_tree().create_timer(delay).timeout
	label.text = ""


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		print("clicked")
		game_started.emit()
		
		
