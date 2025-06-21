class_name Battery extends PowerSourceComponent

## The PowerSource resource that defines the properties of this component.
# @export var power_source_component: PowerSourceComponent
@export var power_source: PowerSource
@export var interact_component: InteractComponent
@onready var debug_label: RichTextLabel = $debug_label




func _process(_delta: float) -> void:
	DebugTools.update_debug_label(debug_label, "Power: " + str(snappedf(current_power, 0.5)) + "/" + str(snappedf(max_power, 0.5)))


func _ready() -> void:
	SignalBus.pressed_interact.connect(interact_component.reparent_to_player)
	randomize_power_level()
	initialize_power_source()


## Randomizes starting power level if enabled.
func randomize_power_level() -> void:
	if randomize_power:
		current_power = randf_range(rand_min, max_power)


## Initializes the power source with default values.
func initialize_power_source():
	power_source = PowerSource.new()
	power_source.current_power = current_power
	power_source.max_power = max_power
	power_source.rand_min = rand_min
	power_source.min_power = min_power
	if current_power > max_power:
		current_power = max_power
