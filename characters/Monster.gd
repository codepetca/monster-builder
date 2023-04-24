class_name Monster
extends Pickable

@onready var animation_player = $AnimationPlayer
@onready var shadow = $Sprites/Shadow
@onready var body = $Sprites/Body
@onready var eye = $Sprites/Eye
@onready var body_old = $Sprites/BodyOld
@onready var eye_old = $Sprites/EyeOld

var costume: Dictionary = {"body": Texture2D, "eye": Texture2D}
var texture_filenames: Array[String]: get = _get_texture_filenames
var id: String: get = _get_id
var mode: MOVE_MODE = MOVE_MODE.MOVE

enum MOVE_MODE {MOVE, FROZEN}


func random_costume():
#	body_old.texture = costume.body
#	eye_old.texture = costume.eye
	costume.body = G.all_textures["bodies"][randi_range(0,1)]#.pick_random()
	costume.eye = G.all_textures["eyes"][randi_range(0,1)]#.pick_random()

	update_appearance()
#	animation_player.play("change_costume")


func update_appearance():
	body.texture = costume.body
	eye.texture = costume.body


# Called when the node enters the scene tree for the first time.
func _ready():
	if mode == MOVE_MODE.MOVE:
		velocity = Vector2(speed + randf_range(0, 300), 0)
	else:
		velocity = Vector2.ZERO
		animation_player.stop()
	update_appearance()


func _process(delta):
	position += velocity.rotated(rotation) * delta


func action_on_pickup():
	scale = scale * 1.2
	animation_player.stop()
	shadow.hide()


func action_on_drop():
	scale = scale/1.2
	animation_player.play("idle")
	shadow.show()


func dead():
	animation_player.play("dead")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()


func _get_texture_filenames():
	var filenames: Array[String] = []
	for key in costume:
		filenames.append(costume[key].resource_path)
	return filenames


func _get_id():
	var string_id = ""
	for key in costume:
		string_id += costume[key].resource_path
	return string_id


func equals(monster: Monster) -> bool:	
	return monster.id == id
