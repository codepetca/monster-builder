class_name Costume
extends Resource


var outfit: Dictionary
#{
#	"body": {
#		"name": "bodyA.png"
#		"texture": Texture2D
#	},
#}

var outfit_id: Dictionary
#{
#	"body": "bodyA.png",
#	"eye": "eyeA.png"
#}


var body_texture: Texture2D:
	get: return outfit.body.texture

var eye_texture: Texture2D:
	get: return outfit.eye.texture

# Concatenation of texture filenames
#var id: String


# initialize with a Costume or JSON String
func _init(costume_or_json = null):
	change_outfit(costume_or_json)


func create_outfit_from_json(json: String) -> Dictionary:
	var data = JSON.parse_string(json)
	var new_outfit = {}
	for category in data.keys():
		var texture = ResourceLoader.load(data[category].name, "Texture", ResourceLoader.CACHE_MODE_REUSE)
		new_outfit[category] = {
			"name": data[category],
			"texture": texture
		}
	return new_outfit


# Create an id for this costume by concatenating its texture filenames
func _create_outfit_id() -> Dictionary:
	var dict: Dictionary = {}
	for category in outfit:
		dict[category] = outfit[category].name
	return dict


func equals(other: Costume):
	return self.outfit_id.hash() == other.outfit_id.hash()


func change_outfit(costume = null):
	if costume is Costume:
		outfit = costume.outfit
	elif costume is String:
		outfit = create_outfit_from_json(costume)
	else:
		outfit["body"] = G.all_costumes["body"][randi_range(0,1)]
		outfit["eye"] = G.all_costumes["eye"][randi_range(0,1)]
	outfit_id = _create_outfit_id()
	

func to_json() -> String:
	return JSON.stringify(outfit_id)


static func from_json(json: String) -> Costume:
	return Costume.new(json)
