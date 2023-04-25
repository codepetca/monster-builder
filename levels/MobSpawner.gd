class_name MobSpawner
extends Node

@onready var mob_path = $MobPath
@onready var mob_spawn_point = $MobPath/MobSpawnPoint

enum SPAWN_DIRECTION { left, right, left_right, full }

var _Monster: PackedScene = preload("res://characters/Monster.tscn")
var rotation_variance: float = PI/2

var y_spawn: Dictionary = { "min": 0.0, "max": 0.0 }

func _ready():
	y_spawn.min = get_viewport().size.y * 1.0/6
	y_spawn.max = get_viewport().size.y * 5.0/6
#	_set_spawn_path()


## Set the spawn path of monsters appearing on screen
##
## The direction to spawn from:
## left, right, left-right, full
func _set_spawn_path(direction: SPAWN_DIRECTION = SPAWN_DIRECTION.left):
	var curve = mob_path.curve
	var points = []
	match direction:
		SPAWN_DIRECTION.left:
			points = [Vector2(0, get_viewport().size.y), Vector2.ZERO]
		SPAWN_DIRECTION.right:
			points = [Vector2(get_viewport().size.x, 0), get_viewport().size]
		SPAWN_DIRECTION.left_right:
			pass
		SPAWN_DIRECTION.full:
			points = [Vector2.ZERO, Vector2(get_viewport().size.x, 0), get_viewport().size, Vector2(0, get_viewport().size.y)]
			points.append(Vector2.ZERO) # close the path
			rotation_variance += randf_range(-PI / 4, PI / 4)
	for point in points:
		curve.add_point(point)


func get_random(mode:= Monster.MOVE_MODE.FROZEN) -> Monster:
	var mob = _Monster.instantiate() as Monster
	mob.mode = mode
	return mob


## Spawn a monster.
##
## Set 'add' to false to create a monster but not add it to the node
func spawn() -> Monster:
	var mob = get_random(Monster.MOVE_MODE.MOVE)
#	mob_spawn_point.progress_ratio = randf() * 2.0/3 + 1.0/6
#	mob.position = mob_spawn_point.position
#	mob.rotation = mob_spawn_point.rotation + rotation_variance
	mob.position = Vector2(0, randf_range(y_spawn.min, y_spawn.max))
	add_child(mob)
	return mob

