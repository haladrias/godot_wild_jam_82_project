class_name Player extends Entity

func _ready() -> void:
	#detection_component.proximity_detection_triggered.connect(panic)
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	pass

func _physics_process(_delta):
	movement_component.handle_movement(self, input_component.get_input_direction())
	move_and_slide()
	entity.look_at(input_component.get_mouse_location())
	SignalBus.player_position_changed.emit(global_position)
	return
