class_name PowerConsumerComponment extends Node2D
## Component for objects that need to draw power from a PowerSource
signal power_activated
signal power_deactivated
@export_group("Power Consumer Stats")
## The amount of power drained per tick
@export_range(1.0, 100.0, 0.1) var drain_per_tick: float = 0.5
## The amount of time in seconds between each drain tick
@export_range(0.01, 2.0, 0.01) var tick_interval: float = 0.25
var can_drain: bool = false
var is_powered: bool = false

## The power source to drain
func start_drain(power_source: PowerSourceComponent) -> void:
	power_source.powersource_is_connected = true
	can_drain = true
	# TODO: sound/animations
	drain_power_source(power_source)
	print("Starting drain")


## Drains the power source by a given amount per tick until fully drained
func drain_power_source(power_source: PowerSourceComponent) -> void:
	print("Attempt to drain power source")
	# TODO: Rework this logic to drain to a device
	power_activated.emit(power_source) # Turns on flood_light
	while power_source.current_power > power_source.min_power and can_drain:
		print("Draining power source")
		is_powered = true
		power_source.current_power -= drain_per_tick
		if power_source.current_power <= power_source.min_power:
			power_source.current_power = power_source.min_power
			is_powered = false
			power_depleted(power_source)
			power_deactivated.emit(power_source)
		await get_tree().create_timer(tick_interval).timeout
		continue


func stop_drain() -> void:
	can_drain = false
	is_powered = false

func power_depleted(power_source) -> void:
	is_powered = false
	power_source.depleted.emit() # Connected to FloodLight
