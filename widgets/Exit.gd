class_name Exit
extends Area2D


var target_costume: Costume


func _ready():
	Signals.target_updated.connect(func(costume): target_costume = costume)
	Signals.pickable_dropped.connect(_on_pickable_dropped)


## Check if the pickable was dropped on this widget
func _on_pickable_dropped(mob: Monster):
	for body in get_overlapping_bodies():
		if body == mob:
			_on_body_entered(mob)


func _on_body_entered(mob):
	if mob is Monster:
		if mob.costume.equals(target_costume):
			Signals.score_increased_by.emit(10)
		else:
			Signals.score_increased_by.emit(-10)
		mob.dead()
