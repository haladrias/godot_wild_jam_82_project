class_name PowerSourceComponent extends Node2D
## Manages logic for PowerSource such as charging and discharging



## Tracks if this power source is currently connected to and powering a device.
var powersource_is_connected: bool = false

func attach_to_charger(charger: PowerChargerComponent) -> void:
	charger.connect_to_power_source(self)