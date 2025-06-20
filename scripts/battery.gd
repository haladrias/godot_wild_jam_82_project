class_name Battery extends PowerSourceComponent

## The PowerSource resource that defines the properties of this component.
@export var power_source: PowerSource
@export var power_source_component: PowerSourceComponent
@export var interact_component: InteractComponent
@onready var debug_label: RichTextLabel = $debug_label
@export var randomize_power: bool = false
## The minimum power level that a randomized PowerSource can have.
@export_range(0.0, 100.0, 5.0) var rand_min: float = 0.0


func _process(_delta: float) -> void:
	DebugTools.update_debug_label(debug_label, "Power: " + str(snappedf(power_source.current_power, 0.5)) + "/" + str(snappedf(power_source.max_power, 0.5)))


func _ready() -> void:
	SignalBus.pressed_interact.connect(interact_component.reparent_to_player)
	power_source = PowerSource.new()
	if not power_source_component:
		printerr("Error: Battery requires a PowerSourceComponent.")
	DebugTools.set_timer(.01)
	initialize_power_source()
	randomize_power_level()


## Randomizes starting power level if enabled.
func randomize_power_level() -> void:
	if randomize_power:
		power_source.current_power = randf_range(rand_min, power_source.max_power)


## Initializes the power source with default values.
func initialize_power_source():
	if power_source:
		if power_source.current_power > power_source.max_power:
			power_source.current_power = power_source.max_power
