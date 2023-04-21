class_name Monster
extends Pickable

@onready var body: Sprite2D = $Body
@onready var eye: Sprite2D = $Eye
@onready var bodyAnimationPlayer: AnimationPlayer = $BodyAnimationPlayer
@onready var eyeAnimationPlayer: AnimationPlayer = $EyeAnimationPlayer
@onready var dead_animation_player = $DeadAnimationPlayer

var textures: Dictionary = {"body": Texture2D, "eye": Texture2D}
var texture_filenames: Array[String]: get = _get_texture_filenames
var id: String: get = _get_id
var mode = "NON_STATIC"

#static var MODE: int = {STATIC: 0, NON_STATIC: 1}
#
#enum MODE {
#	STATIC, NON_STATIC
#}


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
	if mode == "NON_STATIC":
		velocity = Vector2(speed + randf_range(0, 300), 0)
	else:
		velocity = Vector2.ZERO
		bodyAnimationPlayer.stop()
		eyeAnimationPlayer.stop()
	body.texture = textures["body"]
	eye.texture = textures["eye"]


func _process(delta):
	position += velocity.rotated(rotation) * delta


func dead():
	dead_animation_player.play("dead")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()



#
#func _on_area_2d_input_event(_viewport, event, _shape_idx):
#	if event is InputEventScreenTouch and event.pressed:
#		picked_up.emit(self)
#		monster_tapped.emit(self)
