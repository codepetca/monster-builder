extends CanvasLayer


@onready var detector_top = $DetectorTop
@onready var detector_bottom = $DetectorBottom
@onready var mob_spawner = $MobSpawner

var top_target_mob: Monster
var bottom_target_mob: Monster


func set_targets():
	top_target_mob = mob_spawner.get_random()
	bottom_target_mob = mob_spawner.get_random()
	detector_top.add_child(top_target_mob)
	detector_bottom.add_child(bottom_target_mob)
#	top_target_mob.velocity = Vector2.ZERO



func _on_detector_top_body_entered(body):
	get_parent().score_updated.emit()


func _on_detector_bottom_body_entered(body):
	pass # Replace with function body.
