extends CanvasLayer


@onready var mob_spawner = $MobSpawner
@onready var mob_target_top = $Detectors/Top/MobTargetTop
@onready var mob_target_bottom = $Detectors/Bottom/MobTargetBottom
@onready var detectors = $Detectors
@onready var detector_top = $Detectors/Top
@onready var detector_bottom = $Detectors/Bottom


var top_target_mob: Monster
var bottom_target_mob: Monster


func set_targets():
	top_target_mob = mob_spawner.get_random()
	bottom_target_mob = mob_spawner.get_random()
	mob_target_top.add_child(top_target_mob)
	mob_target_bottom.add_child(bottom_target_mob)
	detectors.show()


func _on_detector_top_body_entered(body):
	get_parent().score_updated.emit()


func _on_detector_bottom_body_entered(body):
	pass # Replace with function body.
