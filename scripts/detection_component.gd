extends Node2D
class_name DetectionComponent
signal proximity_detection_triggered
signal proximity_detection_stopped
signal view_cone_detection_triggered
signal view_cone_detection_stopped

func set_view_cone_rotation(direction):
	look_at(direction)


func proximity_detected(area: Area2D):
	proximity_detection_triggered.emit(area)


func proximity_no_longer_detected(area: Area2D):
	proximity_detection_stopped.emit(area)


func view_cone_detected(area: Area2D):
	# TODO: Trigger seen behaviour
	if area.is_in_group("Detectable"):
		view_cone_detection_triggered.emit(area)
	pass

func view_cone_no_longer_detected(area: Area2D):
	view_cone_detection_stopped.emit(area)
