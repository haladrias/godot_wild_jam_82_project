class_name PowerConsumer extends PowerConsumerComponment
@onready var debug_label: RichTextLabel = $DebugLabel
# @export var power_consumer_component: PowerConsumerComponment # TODO: This needs a rework - it's redundant to have as a component if I can extend the class instead?
@onready var consume_area: Area2D = $ConsumeArea

var battery_connected: bool = false
var power_is_available: bool = false


func _on_consume_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("PowerSource") and battery_connected == false:
		var battery = area.get_parent()
		call_deferred("reparent_to_consumer", battery)
		battery_connected = true
		battery.global_position = global_position
		DebugTools.update_debug_label(debug_label, str(battery.name) + " connected")

		## Tell power_consumer_component to drain battery
		start_drain(battery)
		SignalBus.battery_connected_to_consumer()

func reparent_to_consumer(b) -> void:
	b.reparent(self)

func _on_consume_area_area_exited(area: Area2D) -> void:
	if not check_battery_connected():
	## Disconnecting the battery
		if area.is_in_group("PowerSource") and battery_connected == true:
			battery_connected = false
			DebugTools.update_debug_label(debug_label, "Battery disconnected")
			stop_drain()
		else:
			pass

func check_battery_connected() -> bool:
	var curr_area = consume_area.get_overlapping_areas()
	for area in curr_area:
		if area.is_in_group("PowerSource"):
			return true
	return false
