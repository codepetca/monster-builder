extends Node

## Load all costume resources into memory
var all_costumes: Dictionary

func _ready():
	load_textures_to_dict(all_costumes, "body")
	load_textures_to_dict(all_costumes, "eye")


# Load PNG files
func load_textures_to_dict(dict: Dictionary, begins_with: String):
	var path = "res://assets/images/monster/"
	var filenames: Array[String] = dir_contents(path)
	if not all_costumes.has(begins_with):
		all_costumes[begins_with] = []
	for file in filenames:
		if file.begins_with(begins_with):
			dict[begins_with].append(load(path + file))


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

