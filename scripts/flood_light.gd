class_name FloodLight extends PowerConsumer
@export var detection_component: DetectionComponent
# Add logic to create light beam that deters enemy
func _ready() -> void:
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	self.power_activated.connect(power_device)
	self.power_deactivated.connect(unpower_device)
	light_off()
	detection_component.collision_polygon_2d.modulate = Color(255,147,0,.8)

func detected(body):
	DebugTools.update_debug_label(debug_label, "I detected a " + body.name)
	if body.is_in_group("Enemy") and is_powered:
		body.run_away_from_light()

func not_detected(body):
	DebugTools.update_debug_label(debug_label, "I think I lost " + body.name)

#! Disable and enable light beam depending on device power; probably needs bool changed
func power_device(_power_source) -> void:
	if is_powered:
		light_on()
	elif is_powered == false:
		light_off()

func unpower_device() -> void:
	is_powered = false

func light_off() -> void:
	detection_component.view_cone.collision_layer = 0
	DebugTools.update_debug_label(debug_label, "Power off")
	# detection_component.view_cone.hide()

func light_on() -> void:
	detection_component.view_cone.collision_layer = 1
	DebugTools.update_debug_label(debug_label, "Power on")
	# detection_component.view_cone.show()
