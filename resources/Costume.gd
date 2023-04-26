class_name Costume
extends Resource

var outfit: Dictionary = {"body": Texture2D, "eye": Texture2D}

var body_texture: Texture2D:
	get: return outfit.body
var eye_texture: Texture2D:
	get: return outfit.eye

# Concatenation of texture filenames
var id: String


# Create an id for this costume by concatenating its texture filenames
func _create_id() -> String:
	var arr: Array[String] = []
	for key in outfit:
		var parts = outfit[key].resource_path.split("/")
		var filename = parts[parts.size() - 1]
		arr.append(filename)
	arr.sort()
	return ",".join(arr)


func _init(costume: Costume = null):
	if costume:
		outfit = costume.outfit
	else:
		change_outfit()
	id = _create_id()


func equals(other: Costume):
	return self.id == other.id


func change_outfit(costume: Costume = null):
	if costume and not costume.outfit == null:
		outfit = costume.outfit.duplicate()
	else:
		outfit.body = G.all_costumes.body[randi_range(0,1)]
		outfit.eye = G.all_costumes.eye[randi_range(0,1)]

