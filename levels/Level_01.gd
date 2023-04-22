extends CanvasLayer


@onready var mob_spawner = $MobSpawner
@onready var detector_right = $DetectorRight
@onready var marker_right = $DetectorRight/Marker2D
@onready var detector_top = $DetectorTop
@onready var marker_top = $DetectorTop/Marker2D


var target: Monster


func set_targets():
	target = mob_spawner.get_random()
	marker_right.add_child(target)
	detector_right.show()
#	var sprite = Sprite2D.new()
#	sprite.texture = load("res://assets/images/monster/eye_dead.png")
#	marker_top.add_child(sprite)
	

func _on_detector_right_body_entered(body):
	if body is Monster:
		if body.equals(target):
			Signals.increase_score.emit(10)
		else:
			Signals.increase_score.emit(-5)
		body.dead()


func _on_detector_top_body_entered(body):
	if body is Monster:
		body.dead()
