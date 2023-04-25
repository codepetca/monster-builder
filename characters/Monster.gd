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
# monster id is same as its costume id
var id: String:
	get: return costume.id

var mode: MOVE_MODE = MOVE_MODE.MOVE
var normal_velocity: Vector2


func change_costume():
	if costume:
		body_old.texture = costume.body_texture
		eye_old.texture = costume.eye_texture
	costume.change_outfit()
	update_appearance()
	animation_player.play("change_costume")


func update_appearance():
	body_sprite.texture = costume.body_texture
	eye_sprite.texture = costume.eye_texture


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "change_costume":
		animation_player.play("idle")


func _ready():
	costume = Costume.new()
	normal_velocity = BASE_VELOCITY + Vector2(randf_range(0, 300), 0)	
	if mode == MOVE_MODE.MOVE:
		velocity = normal_velocity
	else:
		velocity = Vector2.ZERO
		animation_player.stop()
	update_appearance()


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


func equals(monster: Monster) -> bool:	
	return monster.id == id


