extends Level

@onready var detector_right = $DetectorRight as Area2D
@onready var marker_right = $DetectorRight/Marker2D as Marker2D
@onready var widget = $Widget as Widget
@onready var mob_spawn_timer = $MobSpawnTimer as Timer


var target_monster: Monster
var target_score: int = 20
var score: int = 0


func _ready():
	mob_spawner = $MobSpawner as MobSpawner
	mob_spawn_timer.timeout.connect(_on_mob_spawn_timer_timeout)
	Signals.score_updated.emit(score)


func start():
	target_monster = mob_spawner.get_random()
	marker_right.add_child(target_monster)
	detector_right.show()
	mob_spawn_timer.start()


func _process(_delta):
	if score >= target_score:
		level_complete.emit(score)


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
