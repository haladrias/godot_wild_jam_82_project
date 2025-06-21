extends Node2D
class_name InputComponent

@export_subgroup("Settings")
@export var speed: float = 70
var input_direction: Vector2 = Vector2.ZERO
var mouse_location: Vector2


func _physics_process(_delta):
	get_input_direction()
	get_interact_input()


func get_interact_input():
	if Input.is_action_just_pressed("ui_interact"):
		SignalBus.pressed_interact.emit()


func get_input_direction() -> Vector2:
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_direction = input_direction.normalized()
	return input_direction


func get_mouse_location() -> Vector2:
	mouse_location = get_global_mouse_position()
	return mouse_location
