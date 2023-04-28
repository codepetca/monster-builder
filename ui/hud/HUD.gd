extends CanvasLayer


@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var v_box_container = $Panel/VBoxContainer
@onready var time_label = $MarginContainer/HBoxContainer/TimeLabel


func _ready():
	Signals.score_updated.connect(_on_score_updated)
	Signals.time_updated.connect(_on_time_updated)


func _on_main_wanted_updated(monster: Monster):
	for texture_filename in monster.texture_filenames:
		var texture_rect = TextureRect.new()
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.texture = load(texture_filename)
		v_box_container.add_child(texture_rect)


func _on_score_updated(score: int):
	score_label.text = str(score)


# Function to update the Label with the remaining time
func _on_time_updated(time: int):
	var minutes = time / 60
	var seconds = time % 60
	time_label.text = "%d:%02d" % [minutes, seconds]
