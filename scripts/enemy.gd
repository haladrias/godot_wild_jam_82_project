class_name Enemy extends Entity

func _ready() -> void:
	#detection_component.proximity_detection_triggered.connect(panic)
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	pass

func _process(_delta):
	# TODO: parameters to pass into handle_movement should be self, and some other direction as determined by pathfinding
	#movement_component.handle_movement(self, input_component.get_input_direction())
	# move_and_slide()
	return
