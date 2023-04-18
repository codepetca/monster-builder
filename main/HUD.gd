extends CanvasLayer


@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel


func _on_main_score_updated(score: int):
	score_label.text = str(score)
