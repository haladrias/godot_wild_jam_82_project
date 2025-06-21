class_name FloodLight extends PowerConsumer
@export var detection_component: DetectionComponent

# Add logic to create light beam that deters enemy
func _ready() -> void:
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")


func detected(body):
	DebugTools.update_debug_label(debug_label, "I detected a " + body.name)
	if body.is_in_group("Enemy"):
		body.run_away_from_light()


func not_detected(body):
	DebugTools.update_debug_label(debug_label, "I think I lost " + body.name)
