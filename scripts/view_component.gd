extends Node2D
class_name DetectionComponent
signal proximity_detection_triggered
signal proximity_detection_stopped

func set_view_cone_rotation(direction):
	look_at(direction)


func proximity_detected(area: Area2D):
	proximity_detection_triggered.emit(area)


func proximity_no_longer_detected(area: Area2D):
	proximity_detection_stopped.emit(area)


func was_seen():
	# TODO: Trigger seen behaviour
	pass
