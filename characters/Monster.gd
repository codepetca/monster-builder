class_name Monster
extends CharacterBody2D

@onready var body: Sprite2D = $Body
@onready var eye: Sprite2D = $Eye
@onready var bodyAnimationPlayer: AnimationPlayer = $BodyAnimationPlayer
@onready var eyeAnimationPlayer: AnimationPlayer = $EyeAnimationPlayer

var speed: float = 100.0

var textures: Dictionary = {"body": Texture2D, "eye": Texture2D}
var texture_example: Dictionary = {"body": load("res://assets/images/body_greenA.png"), "eye": load("res://assets/images/eye_angry_blue.png")}

func equals(monster: Monster) -> bool:
	return monster.textures.hash() == textures.hash()


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed, 0)
	body.texture = textures["body"]
	eye.texture = textures["eye"]


func _process(delta):
	position += velocity.rotated(rotation) * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
