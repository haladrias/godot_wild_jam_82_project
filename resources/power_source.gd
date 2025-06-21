@tool
class_name PowerSource extends Resource
## Describes  a power source that can be charged and discharged.

@export_group("Power Resource Stats")
## The current amount of power stored.
@export_range(0.0, 100.0, 1.0) var current_power: float = 100.0
## The maximum power capacity.
@export_range(1.0, 100.0, 1.0) var max_power: float = 100.0
## The minimum power level that a randomized PowerSource can have.
@export_range(0.0, 100.0, 05.0) var rand_min: float = 0.0
## The minimum power level before the source is considered depleted.
var min_power: float = 0.0