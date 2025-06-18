class_name PowerSourceComponent extends Node2D
## Manages logic for PowerSource such as charging and discharging



## Tracks if this power source is currently connected to and powering a device.
var powersource_is_connected: bool = false

# ## Attempts to provide a certain amount of power.
# ## Returns the amount of power successfully provided.
# func provide_power(amount: float) -> float:
# 	if power_source and power_source.can_provide(amount):
# 		return power_source.discharge(amount)
# 	return 0.0

# ## Charges the power source.
# func charge(amount: float, charge_rate: float, delta: float):
# 	if power_source:
# 		power_source.charge(amount, charge_rate, delta)
