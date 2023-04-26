extends Level

@onready var mob_spawner = $MobSpawner as MobSpawner
@onready var detector_right = $DetectorRight as Area2D
@onready var marker_right = $DetectorRight/Marker2D as Marker2D
@onready var widget = $Widget as Widget


var target_monster: Monster
var target_score: int
var score: int = 0


func _ready():
	set_targets()


func _process(_delta):
	if score >= target_score:
		level_complete.emit()


func set_targets():
	target_monster = mob_spawner.get_random()
	marker_right.add_child(target_monster)
	detector_right.show()
	target_score = score + 100


func _on_detector_right_body_entered(mob):
	if mob is Monster:
		if mob.costume.equals(target_monster.costume):
			score += 10
		else:
			score -= 10
		score_updated.emit(score)
		mob.dead()


func _on_mob_detector_body_entered(mob):
	if mob is Monster:
		mob.pickable = false
		# Don't detect a mob that is already picked up
		if mob.selected: 
			return
		
		if widget.is_on:
			mob.velocity = mob.BASE_VELOCITY
			if mob.costume.equals(target_monster.costume):
				mob.change_costume()
			else:
				mob.change_costume(target_monster.costume)


func _on_mob_detector_body_exited(body):
	if body is Monster:
		body.pickable = true
		body.velocity = body.normal_velocity
