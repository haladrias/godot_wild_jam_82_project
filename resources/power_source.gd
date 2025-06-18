@tool
class_name PowerSource extends Resource

@export_group("Power Source Stats")
## The current amount of power stored.
@export_range(1.0, 100.0, 1.0) var current_power: float = 100.0
## The maximum power capacity.
@export_range(1.0, 100.0, 1.0) var max_power: float = 100.0
## The minimum power level before the source is considered depleted.
var min_power: float = 0.0

# @export_range(1.0, 100.0, 1.0) var power_rate_per_sec: float = 10.0
## Whether the current power level should be randomized at initialization.
@export var randomize_power: bool = false


## Signal emitted when the power level changes.
signal power_changed(current_power, max_power)
## Signal emitted when the power source is fully charged.
signal fully_charged
## Signal emitted when the power source is depleted.
signal depleted

## Charges the power source by a given amount, respecting the charge rate and max power.
func charge(amount: float, charge_rate: float, delta: float) -> float:
	var power_to_add = charge_rate * delta
	var old_power = current_power
	current_power = min(current_power + power_to_add, max_power)

	if old_power < max_power and current_power == max_power:
		fully_charged.emit()

	if old_power != current_power:
		power_changed.emit(current_power, max_power)

	return current_power - old_power

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
