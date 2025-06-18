class_name PowerConsumerComponment extends Node2D
## Component for objects that need to draw power from a PowerSource

## The amount of power this device consumes per second.
@export var consumption_rate: float = 10.0

## A reference to the PowerSourceComponent to draw power from.
@export var power_source_component: PowerSourceComponent

func _process(delta):
	if power_source_component:
		var power_needed = consumption_rate * delta
		var power_received = power_source_component.provide_power(power_needed)

		if power_received < power_needed:
			# The device is not receiving enough power.
			# You could add logic here to make the device turn off or work at a reduced capacity.
			print("Not enough power!")
