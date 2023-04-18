class_name Monster
extends CharacterBody2D

signal monster_tapped(monster: Monster)


@onready var body: Sprite2D = $Body
@onready var eye: Sprite2D = $Eye
@onready var bodyAnimationPlayer: AnimationPlayer = $BodyAnimationPlayer
@onready var eyeAnimationPlayer: AnimationPlayer = $EyeAnimationPlayer
@onready var dead_animation_player = $DeadAnimationPlayer

var speed: float = 100.0

var textures: Dictionary = {"body": Texture2D, "eye": Texture2D}
#var texture_example: Dictionary = {"body": load("res://assets/images/body_greenA.png"), "eye": load("res://assets/images/eye_angry_blue.png")}

var id : get = _get_id


func _get_id():
	var string_id = ""
	for key in textures:
		string_id += textures[key].resource_path
	return string_id


func equals(monster: Monster) -> bool:	
	return monster.id == id


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed + randf_range(0, 300), 0)
	body.texture = textures["body"]
	eye.texture = textures["eye"]


func _process(delta):
	position += velocity.rotated(rotation) * delta


func dead():
	dead_animation_player.play("dead")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		monster_tapped.emit(self)
