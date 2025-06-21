class_name FloodLight extends PowerConsumer
@export var detection_component: DetectionComponent
var is_powered: bool = false
# Add logic to create light beam that deters enemy
func _ready() -> void:
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	self.power_activated.connect(power_device)
	self.power_deactivated.connect(unpower_device)

func detected(body):
	DebugTools.update_debug_label(debug_label, "I detected a " + body.name)


func not_detected(body):
	DebugTools.update_debug_label(debug_label, "I think I lost " + body.name)

#! Disable and enable light beam depending on device power; probably needs bool changed
func power_device(power_source) -> void:
	if battery_connected and power_source.current_power > 0:
		is_powered = true
		detection_component.view_cone.show() #! Doesn't work, needs to toggle collision layer probably
		print("I'm powered")
	else:
		is_powered = false
		detection_component.view_cone.hide()

func unpower_device() -> void:
	is_powered = false