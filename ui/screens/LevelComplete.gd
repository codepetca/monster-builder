extends Screen


@onready var score_label = $CenterContainer/VBoxContainer/ScoreLabel

var score: int


func _ready():
	score_label.text = "Score: " + str(score)


func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		Signals.pop_screen.emit()
		queue_free()
