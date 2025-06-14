extends CharacterBody2D
@export var input_component: InputComponent
@export var movement_component: MovementComponent


func _process(_delta):
	movement_component.handle_movement(self, input_component.input_direction)
	move_and_slide()
	return
