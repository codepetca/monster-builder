class_name Pickable
extends CharacterBody2D


signal picked_up(pick_object: Pickable)


var pickable := true
var selected := false
var speed := 100.0


@onready var collision_shape_2d = $CollisionShape2D


func _init() -> void:
	disable_mode = CharacterBody2D.DISABLE_MODE_KEEP_ACTIVE
	input_pickable = true


func _physics_process(_delta: float) -> void:
	if selected:
		global_transform.origin = get_global_mouse_position()
#		action(delta)


func pickup() -> void:
	if selected:
		return
	selected = true	
	disable_mode = CharacterBody2D.DISABLE_MODE_MAKE_STATIC
	input_pickable = false
	action_on_pickup()


func drop() -> void:
	if not selected:
		return
	selected = false
	disable_mode = CharacterBody2D.DISABLE_MODE_KEEP_ACTIVE
	input_pickable = true
	action_on_drop()


# Override action to be performed when picked up
func action_on_pickup():
	pass


func action_on_drop():
	pass


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenTouch and event.pressed and pickable:
		picked_up.emit(self)

#func _input_event(_viewport, event, _shape_idx):
#	if event is InputEventScreenTouch and event.pressed:
#		emit_signal("picked_up", self)


