extends CanvasLayer


signal level_complete


@onready var mob_spawner = $MobSpawner
@onready var detector_right = $DetectorRight
@onready var marker_right = $DetectorRight/Marker2D
@onready var detector_top = $DetectorTop
@onready var marker_top = $DetectorTop/Marker2D


var target_monster: Monster
var target_score: int
var score: int = 0


func _process(delta):
	if score >= target_score:
		level_complete.emit()


func set_targets():
	target_monster = mob_spawner.get_random()
	marker_right.add_child(target_monster)
	detector_right.show()
	
	target_score = 100
	
	
func _on_detector_right_body_entered(body):
	if body is Monster:
		if body.equals(target_monster):
			Signals.increase_score.emit(10)
		else:
			Signals.increase_score.emit(-5)
		body.dead()


func _on_detector_top_body_entered(body):
	if body is Monster:
		body.dead()
