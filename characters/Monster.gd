class_name Monster
extends Pickable


@onready var animation_player = $AnimationPlayer
@onready var shadow = $Sprites/Shadow
@onready var body_sprite = $Sprites/Body
@onready var eye_sprite = $Sprites/Eye
@onready var body_old = $Sprites/BodyOld
@onready var eye_old = $Sprites/EyeOld

const BASE_VELOCITY := Vector2(150.0, 0)

var costume: Costume :
	get: return costume
	set(new_costume):
		costume = new_costume
		if is_inside_tree():
			update_appearance()

var normal_velocity: Vector2
var is_moving:= false
var destination: Vector2


func _ready():
	normal_velocity = BASE_VELOCITY + Vector2(randf_range(0, 300), 0)
	velocity = normal_velocity
	if not costume:
		costume = Costume.new()
	update_appearance()
	random_move()


func _process(_delta):
	if is_moving:
		if (destination - position).length() > 5:
			var direction = global_position.direction_to(destination)
			velocity = direction * velocity.length()
			move_and_slide()


## Change to a new costume or random if new_costume is null
func change_costume_animated(new_costume: Costume = null):
	if costume:
		body_old.texture = costume.body_texture
		eye_old.texture = costume.eye_texture
	costume.change_outfit(new_costume)
	update_appearance()
	animation_player.play("change_costume")


func update_appearance():
	body_sprite.texture = costume.body_texture
	eye_sprite.texture = costume.eye_texture


func appear_animation():
	animation_player.play("appear")


## Move mob 
func random_move():
	var minxy = get_tree().get_root().get_visible_rect().size * 0.2
	var maxxy = get_tree().get_root().get_visible_rect().size * 0.8
	var x = randf_range(minxy.x, maxxy.x)
	var y = randf_range(minxy.y, maxxy.y)
	destination = Vector2(x, y)
	is_moving = true


## ACTIONS ##

func action_on_pickup():
	scale = scale * 1.2
	animation_player.stop()
	is_moving = false


func action_on_drop():
	scale = scale/1.2
	animation_player.play("idle")
	Signals.pickable_dropped.emit(self)


func dead(callback_after_dead = null):
	if callback_after_dead:
		animation_player.play("dead")
		await animation_player.animation_finished
		callback_after_dead.call()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "change_costume":
		animation_player.play("idle")


func _on_visible_on_screen_notifier_2d_screen_exited():
	dead()


