class_name Costume
extends Resource

var outfit: Dictionary = {"body": Texture2D, "eye": Texture2D}

var body_texture: Texture2D:
	get: return outfit.body
var eye_texture: Texture2D:
	get: return outfit.eye
# Concatenation of texture filenames
var id: String:
	get:
		# concatenate all filenames together
		var arr_string: String = ""
		for key in outfit:
			arr_string += outfit[key].resource_path
		return arr_string


func _init(costume: Costume = null):
	if costume:
		outfit = costume.outfit
	else:
		change_outfit()


func equals(other: Costume):
	return self.id == other.id


func change_outfit():
	outfit.body = G.all_costumes.body[randi_range(0,1)]
	outfit.eye = G.all_costumes.eye[randi_range(0,1)]

