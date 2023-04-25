class_name CostumeResource
extends Resource


var current: Dictionary
var body: Texture2D
var eye: Texture2D


# Concatenation of texture filenames
var id: String:
	get:
		# concatenate all filenames together
		var arr_string: String
		for key in current:
			arr_string += current[key].resource_path
		return arr_string


func equals(other: CostumeResource):
	return self.id == other.id


func set_random():
	body = G.all_costumes.body[randi_range(0,1)]
	eye = G.all_costumes.eye[randi_range(0,1)]

