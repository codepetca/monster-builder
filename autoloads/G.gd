extends Node

const IMAGES_PATH := "res://assets/images/monster/"

## Load all costume resources into memory
var all_costumes: Dictionary
var categories: Array[String] = ["body", "eye"]


func _ready():
	_load_textures(all_costumes, categories)


## Load all filenames in the path into a dictionary of the format:
##	{
##		"body": [
##			{
##				"name": "BodyA.png",
##				"texture": Texture2D
##			},
##			{
##				"name": "BodyB.png",
##				"texture": Texture2D
##			}
##		],
##		"eye": {
##			...
##		}
##	}
func _load_textures(dict: Dictionary, categories: Array[String]):
	var filenames: Array[String] = dir_contents(IMAGES_PATH)
	for category in categories:
		if not dict.has(category):
			dict[category] = []
		for filename in filenames:
			if filename.begins_with(category):
				var image_data = { "name": filename, "texture": load(IMAGES_PATH + filename) }
				dict[category].append(image_data)


## Load PNG files
#func load_textures_to_dict(dict: Dictionary, begins_with: String):
#	var filenames: Array[String] = dir_contents(IMAGES_PATH)
#	if not dict.has(begins_with):
#		dict[begins_with] = []
#	for file in filenames:
#		if file.begins_with(begins_with):
#			dict[begins_with].append(load(IMAGES_PATH + file))


func dir_contents(path: String) -> Array[String]:	
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

