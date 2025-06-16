class_name Player extends Entity

func _physics_process(_delta):
	movement_component.handle_movement(self, input_component.get_input_direction())
	move_and_slide()
	entity.look_at(input_component.get_mouse_location())
	return
