extends Level

@onready var widget = $Widget as Widget
@onready var mob_spawn_timer = $MobSpawnTimer as Timer
@onready var exit = $Exit as Area2D
@onready var marker_2d = $Exit/Marker2D as Marker2D


var target_monster: Monster
var target_score: int = 20
var score: int = 0


func _ready():
	mob_spawner = $MobSpawner as MobSpawner
	mob_spawn_timer.timeout.connect(_on_mob_spawn_timer_timeout)
	Signals.score_updated.emit(score)
	widget.widget_action.connect(_on_widget_widget_action)


func start():
	target_monster = mob_spawner.get_random()
	marker_2d.add_child(target_monster)
	exit.show()
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


func _on_widget_widget_action(mob: Monster, action: Widget.ACTION):
	match action:
		Widget.ACTION.change_costume:
			if mob.costume.equals(target_monster.costume):
				mob.change_costume()
			else:
				mob.change_costume(target_monster.costume)
		Widget.ACTION.teleport:
			pass
	

