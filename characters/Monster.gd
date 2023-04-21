class_name Monster
extends Pickable

@onready var body: Sprite2D = $Body
@onready var eye: Sprite2D = $Eye
@onready var animation_player = $AnimationPlayer

var textures: Dictionary = {"body": Texture2D, "eye": Texture2D}
var texture_filenames: Array[String]: get = _get_texture_filenames
var id: String: get = _get_id
var mode: MOVE_MODE = MOVE_MODE.MOVE

enum MOVE_MODE {MOVE, FROZEN}


func _get_texture_filenames():
	var filenames: Array[String] = []
	for key in textures:
		filenames.append(textures[key].resource_path)
	return filenames


func _get_id():
	var string_id = ""
	for key in textures:
		string_id += textures[key].resource_path
	return string_id


func equals(monster: Monster) -> bool:	
	return monster.id == id


# Called when the node enters the scene tree for the first time.
func _ready():
	if mode == MOVE_MODE.MOVE:
		velocity = Vector2(speed + randf_range(0, 300), 0)
	else:
		velocity = Vector2.ZERO
		animation_player.stop()
	body.texture = textures["body"]
	eye.texture = textures["eye"]


func _process(delta):
	position += velocity.rotated(rotation) * delta


func action_on_pickup():
	scale = scale * 1.2
	animation_player.stop()


func action_on_drop():
	scale = scale/1.2
	animation_player.play("idle")


func dead():
	animation_player.play("dead")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()

