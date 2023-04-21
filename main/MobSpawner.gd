class_name MobSpawner
extends Node

@onready var mob_path = $MobPath
@onready var mob_spawn_point = $MobPath/MobSpawnPoint


var _Monster: PackedScene = preload("res://characters/Monster.tscn")
var all_textures: Dictionary = {"bodies":[], "eyes":[]}
var rotation_variance: float = PI/2


func _ready():
	load_textures_to_dict(all_textures)
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



func get_random() -> Monster:
	var mob = _Monster.instantiate() as Monster
	mob.textures["body"] = all_textures["bodies"][randi_range(0,1)]#.pick_random()
	mob.textures["eye"] = all_textures["eyes"][randi_range(0,1)]#.pick_random()
	mob.mode = "STATIC"
	
	return mob


## Spawn a monster.
##
## Set 'add' to false to create a monster but not add it to the node
func spawn() -> Monster:
	var mob = get_random()
	add_child(mob)
	mob_spawn_point.progress_ratio = randf()
	mob.position = mob_spawn_point.position
	mob.rotation = mob_spawn_point.rotation + rotation_variance
	return mob


# Load PNG files
func load_textures_to_dict(dict: Dictionary):
	var path = "res://assets/images/"
	var filenames: Array[String] = dir_contents(path)
	for file in filenames:
		if file.begins_with("body"):
			dict["bodies"].append(load(path + file))
		if file.begins_with("eye"):
			dict["eyes"].append(load(path + file))


func dir_contents(path) -> Array[String]:	
	var files: Array[String] = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				if file_name.to_lower().ends_with("png"):
					files.append(file_name)
				file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	return files
