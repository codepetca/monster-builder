extends Level

@onready var mob_spawn_timer = $MobSpawnTimer as Timer
@onready var remaining_timer = $RemainingTimer as Timer
@onready var transporter = $Transporter as Transporter


var target_costume: Costume
var target_score: int = 100
var score: int = 0
var time_remaining: int = 15


func _ready():
	mob_spawner = $MobSpawner as MobSpawner
	mob_spawn_timer.timeout.connect(_on_mob_spawn_timer_timeout)
	remaining_timer.timeout.connect(_on_remaining_timer_timeout)
	Signals.score_updated.emit(score)
	Signals.score_increased_by.connect(_on_score_increase_by)
	Signals.portal_spawn.connect(_on_portal_spawn)


func start():
	target_costume = Costume.new()
	Signals.target_updated.emit(target_costume)
	mob_spawn_timer.start()
	if multiplayer.is_server():
		remaining_timer.start()


func _on_portal_spawn(costume_json: String):
	var costume = Costume.from_json(costume_json)
	var mob = mob_spawner.spawn(costume, transporter.position)
	mob.picked_up.connect(_on_pickable_picked_up)


func _on_remaining_timer_timeout():
	if time_remaining > 1:
		time_remaining -= 1
		Signals.time_updated.emit(time_remaining)
	else:
		Signals.level_complete.emit(score)


func _on_score_increase_by(amount: int):
	_increase_score_by.rpc_id(1, amount)

@rpc("any_peer", "call_local")
func _increase_score_by(amount: int):
	if multiplayer.is_server():
		score += amount
		Signals.score_updated.emit(score)
