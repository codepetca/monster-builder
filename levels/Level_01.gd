extends CanvasLayer


@onready var mob_spawner = $MobSpawner
@onready var detector = $Detector
@onready var marker_2d = $Detector/Marker2D


var target: Monster


func set_targets():
	target = mob_spawner.get_random()
	marker_2d.add_child(target)
	detector.show()


func _on_detector_body_entered(body):
	print("entered")
	if body is Monster:
		if body.equals(target):
			Signals.increase_score.emit(10);
