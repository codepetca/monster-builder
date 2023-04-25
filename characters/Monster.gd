class_name Monster
extends Pickable


@onready var animation_player = $AnimationPlayer
@onready var shadow = $Sprites/Shadow
@onready var body_sprite = $Sprites/Body
@onready var eye_sprite = $Sprites/Eye
@onready var body_old = $Sprites/BodyOld
@onready var eye_old = $Sprites/EyeOld

enum MOVE_MODE {MOVE, FROZEN}

const BASE_VELOCITY := Vector2(150.0, 0)

var costume: Costume
var target_costume: Costume

var mode: MOVE_MODE = MOVE_MODE.MOVE
var normal_velocity: Vector2


func _ready():
	costume = Costume.new()
	normal_velocity = BASE_VELOCITY + Vector2(randf_range(0, 300), 0)	
	if mode == MOVE_MODE.MOVE:
		velocity = normal_velocity
	else:
		velocity = Vector2.ZERO
		animation_player.stop()
	update_appearance()


## Change to a new costume or random if new_costume is null
func change_costume(new_costume: Costume = null):
	if costume:
		body_old.texture = costume.body_texture
		eye_old.texture = costume.eye_texture
	if new_costume:
		costume = new_costume
	else:
		costume.change_outfit()
	update_appearance()
	animation_player.play("change_costume")


func update_appearance():
	body_sprite.texture = costume.body_texture
	eye_sprite.texture = costume.eye_texture


## ACTIONS ##

func _process(delta):
	position += velocity.rotated(rotation) * delta


func action_on_pickup():
	scale = scale * 1.2
	animation_player.stop()
#	collision_layer = 3


func action_on_drop():
	scale = scale/1.2
	animation_player.play("idle")
#	collision_layer = 2


func dead():
	animation_player.play("dead")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "change_costume":
		animation_player.play("idle")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()


