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
		# Add all texture filenames to array, sort it, then
		# concatenate it
		var arr: Array[String] = []
		for key in outfit:
			arr.append(outfit[key].resource_path)
		arr.sort()
		return arr.reduce(func(a, str): return a + str)


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

