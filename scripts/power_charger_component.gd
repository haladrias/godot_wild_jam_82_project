class_name PowerChargerComponent extends Node2D
## Used to handle charging and discharging functions that will be used by batteries, devices, and powerrs

@export_group("Power Charger Stats")
## The amount of power charged per tick
@export_range(1.0, 100.0, 0.1) var charge_per_tick: float = 1.0
## The amount of time in seconds between each charge tick
@export_range(0.01, 2.0, 0.01) var tick_interval: float = 0.05
var can_charge: bool = false
## The power source to charge
func start_charge(power_source: PowerSourceComponent) -> void:
	power_source.powersource_is_connected = true
	can_charge = true
	# TODO: sound/animations
	charge_power_source(power_source)
	print("Starting charge")


## Charges the power source by a given amount per tick until fully charged
func charge_power_source(power_source: PowerSourceComponent) -> void:
	print("Attempt to charge power source")
	while power_source.current_power < power_source.max_power and can_charge:
		print("Charging power source")
		power_source.current_power += charge_per_tick
		if power_source.current_power >= power_source.max_power:
			power_source.current_power = power_source.max_power
			power_source.fully_charged.emit() # TODO: what to connect this to?
		await get_tree().create_timer(tick_interval).timeout
		continue


func stop_charge() -> void:
	can_charge = false