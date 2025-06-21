class_name Charger extends Node2D
@onready var debug_label: RichTextLabel = $DebugLabel
@export var power_charger_component: PowerChargerComponent
@onready var charge_area: Area2D = $ChargeArea


# signal battery_connected_to_charger
var battery_connected: bool = false


func _on_charge_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("PowerSource") and battery_connected == false:
		var battery = area.get_parent()
		call_deferred("reparent_to_charge", battery)
		battery_connected = true
		battery.global_position = global_position
		DebugTools.update_debug_label(debug_label, str(battery.name) + " connected")

		## Tell power_charger_component to charge battery
		power_charger_component.start_charge(battery)
		SignalBus.battery_connected_to_charger()


func reparent_to_charge(b) -> void:
	b.reparent(self)


func _on_charge_area_area_exited(area: Area2D) -> void:
	if not check_battery_connected():
	## Disconnecting the battery
		if area.is_in_group("PowerSource") and battery_connected == true:
			battery_connected = false
			DebugTools.update_debug_label(debug_label, "Battery disconnected")
			power_charger_component.stop_charge()
		else:
			pass


func check_battery_connected() -> bool:
	var curr_area = charge_area.get_overlapping_areas()
	for area in curr_area:
		if area.is_in_group("PowerSource"):
			return true
	return false
