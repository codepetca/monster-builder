extends CanvasLayer


signal level_complete
signal score_updated(score: int)

signal room_relocate(monster)


@onready var mob_spawner = $MobSpawner
@onready var detector_right = $DetectorRight
@onready var marker_right = $DetectorRight/Marker2D
@onready var detector_top = $DetectorTop
@onready var marker_top = $DetectorTop/Marker2D
@onready var mob_spawn_timer = $MobSpawnTimer
@onready var change_room = $ChangeRoom


var target_monster: Monster
var target_score: int = 20
var score: int = 0


func _process(_delta):
	if score >= target_score:
		level_complete.emit()


func set_targets():
	target_monster = mob_spawner.get_random()
	marker_right.add_child(target_monster)
	detector_right.show()


func _on_detector_right_body_entered(body):
	if body is Monster:
		if body.equals(target_monster):
			score += 10
		else:
			score -= 5
		score_updated.emit(score)
		body.dead()


func _on_detector_top_body_entered(body):
	if body is Monster:
		var mob = body.duplicate()
		room_relocate.emit(mob)
		body.queue_free()


func _on_change_room_go_back(monster):
	monster.position = Vector2(get_viewport().size.x / 2, 150)
	add_child(monster)
	monster.show()
