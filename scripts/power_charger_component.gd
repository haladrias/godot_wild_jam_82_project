class_name PowerChargerComponent extends Node2D
## Used to handle charging and discharging functions that will be used by batteries, devices, and powerrs


# detect when battery is in area
# charge battery if possible
# if battery is full, stop charging
func connect_to_power_source(power_source: PowerSourceComponent) -> void:
	power_source.powersource_is_connected = true
