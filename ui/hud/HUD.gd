extends CanvasLayer


@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var v_box_container = $Panel/VBoxContainer


func _ready():
	Signals.score_updated.connect(_on_score_updated)


func _on_main_wanted_updated(monster: Monster):
	for texture_filename in monster.texture_filenames:
		var texture_rect = TextureRect.new()
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT_PROPORTIONAL
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.texture = load(texture_filename)
		v_box_container.add_child(texture_rect)


func _on_score_updated(score: int):
	score_label.text = str(score)
