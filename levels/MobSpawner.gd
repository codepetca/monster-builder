class_name MobSpawner
extends Node

@onready var mob_path = $MobPath
@onready var mob_spawn_point = $MobPath/MobSpawnPoint


var _Monster: PackedScene = preload("res://characters/Monster.tscn")
var rotation_variance: float = PI/2


func _ready():
	_set_spawn_path("left")


## Set the spawn path of monsters appearing on screen
##
## The direction to spawn from:
## left, right, left-right, full
func _set_spawn_path(direction: String = "full"):
	var curve = mob_path.curve
	var points = []
	match direction:
		"left":
			points = [Vector2(0, get_viewport().size.y), Vector2.ZERO]
		"right":
			points = [Vector2(get_viewport().size.x, 0), get_viewport().size]
		"left-right":
			pass
		"full":
			points = [Vector2.ZERO, Vector2(get_viewport().size.x, 0), get_viewport().size, Vector2(0, get_viewport().size.y)]
			points.append(Vector2.ZERO) # close the path
			rotation_variance += randf_range(-PI / 4, PI / 4)
	for point in points:
		curve.add_point(point)



func get_random(mode:= Monster.MOVE_MODE.FROZEN) -> Monster:
	var mob = _Monster.instantiate() as Monster
	mob.textures["body"] = G.all_textures["bodies"][randi_range(0,1)]#.pick_random()
	mob.textures["eye"] = G.all_textures["eyes"][randi_range(0,1)]#.pick_random()
	mob.mode = mode
	return mob


## Spawn a monster.
##
## Set 'add' to false to create a monster but not add it to the node
func spawn() -> Monster:
	var mob = get_random(Monster.MOVE_MODE.MOVE)
	
	mob_spawn_point.progress_ratio = randf() * 2.0 / 3 + 1.0/6
	mob.position = mob_spawn_point.position
	mob.rotation = mob_spawn_point.rotation + rotation_variance
	add_child(mob)
	return mob

