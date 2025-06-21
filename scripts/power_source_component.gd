class_name PowerSourceComponent extends Node2D
## Manages logic for PowerSource such as charging and discharging

# Probably needs to go into a resource
@export_group("Power Source Stats")
## The current amount of power stored.
@export_range(0.0, 100.0, 1.0) var current_power: float = 100.0: set = _set_current_power
## The maximum power capacity.
@export_range(1.0, 100.0, 1.0) var max_power: float = 100.0
## The minimum power level that a randomized PowerSource can have.
@export_range(0.0, 100.0, 05.0) var rand_min: float = 0.0
## The minimum power level before the source is considered depleted.
var min_power: float = 0.0

# @export_range(1.0, 100.0, 1.0) var power_rate_per_sec: float = 10.0
## Whether the current power level should be randomized at initialization.
@export var randomize_power: bool = false

## Tracks if this power source is currently connected to and powering a device.
var powersource_is_connected: bool = false


## Signal emitted when the power level changes.
signal power_changed(current_power, max_power)
## Signal emitted when the power source is fully charged.
signal fully_charged
## Signal emitted when the power source is depleted.
signal depleted

func _ready() -> void:
	print("PowerSourceComponent ready!")

func _set_current_power(value: float) -> void:
	current_power = value
	# power_changed.emit(current_power, max_power)
	# DebugTools.update_debug_label(get_parent().debug_label, "Power: " + str(current_power) + "/" + str(max_power))

## Discharges the power source by a given amount.
func discharge(amount: float) -> float:
	var power_to_remove = amount
	var old_power = current_power
	current_power = max(current_power - power_to_remove, min_power)

	if old_power > min_power and current_power == min_power:
		depleted.emit()

	if old_power != current_power:
		power_changed.emit(current_power, max_power)

	return old_power - current_power

## Returns true if the power source can provide the requested amount of power.
func can_provide(amount: float) -> bool:
	return current_power - amount >= min_power

## Returns the charge level as a percentage.
func get_charge_percentage() -> float:
	if max_power > 0:
		return (current_power / max_power) * 100.0
	return 0.0
