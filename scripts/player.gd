class_name Player extends Entity

func _physics_process(_delta):
	movement_component.handle_movement(self, input_component.get_input_direction())
	move_and_slide()
	entity.look_at(input_component.get_mouse_location())
	SignalBus.player_position_changed.emit(global_position)
	return

##! The below can be uncommented to make the player's viewcone act as a light
# func detected(body):
# 	DebugTools.update_debug_label(debug_label, "I detected a " + body.name)
# 	if body.is_in_group("Enemy"):
# 		body.run_away_from_light()
