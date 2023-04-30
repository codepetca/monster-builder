extends Level

@onready var mob_spawn_timer = $MobSpawnTimer as Timer
@onready var remaining_timer = $RemainingTimer
@onready var transporter = $Transporter


var target_costume: Costume
var target_score: int = 100
var score: int = 0
var time_remaining: int = 130


func _ready():
	mob_spawner = $MobSpawner as MobSpawner
	mob_spawn_timer.timeout.connect(_on_mob_spawn_timer_timeout)
	remaining_timer.timeout.connect(_on_remaining_timer_timeout)
	Signals.score_updated.emit(score)
	Signals.score_increased_by.connect(
		func(amount):
			score += amount
			Signals.score_updated.emit(score)
	)
	Signals.portal_spawn.connect(_on_portal_spawn)


func start():
	target_costume = Costume.new()
	Signals.target_updated.emit(target_costume)
	mob_spawn_timer.start()
	if multiplayer.is_server():
		remaining_timer.start()


func _process(_delta):
	if score >= target_score:
		Signals.level_complete.emit(score)


func _on_detector_right_body_entered(mob):
	if mob is Monster:
		if mob.costume.equals(target_costume):
			score += 10
		else:
			score -= 10
		Signals.score_updated.emit(score)
		mob.dead()


func _on_portal_spawn(costume_json: String):
	var costume = Costume.from_json(costume_json)
	var mob = mob_spawner.spawn(costume, Vector2(100, 300))
	mob.picked_up.connect(_on_pickable_picked_up)


func _on_remaining_timer_timeout():
	if time_remaining > 0:
		time_remaining -= 1
		Signals.time_updated.emit(time_remaining)
