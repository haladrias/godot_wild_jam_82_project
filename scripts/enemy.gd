class_name Enemy extends Entity
@export var pathfinder: Pathfinder
@export var flee_time: float = 1.5
var player_pos
var player_path
var run_away: bool = false


func _ready() -> void:
	#detection_component.proximity_detection_triggered.connect(panic)
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	SignalBus.debug_spacebar_pressed.connect(debug_forward_movement)
	SignalBus.debug_shift_spacebar_pressed.connect(debug_backward_movement)
	get_path_info()

enum RunState {
	AWAY = -2,
	TOWARDS = 2,
}

var run_state: RunState = RunState.TOWARDS

func _process(_delta):
	# TODO: parameters to pass into handle_movement should be self, and some other direction as determined by pathfinding
	#movement_component.handle_movement(self, input_component.get_input_direction())
	# move_and_slide()
	#pathfinder.update_path(vector2i_position())
	pathfinder.update_entity_position(global_position)
	pathfinder.update_path()
	return


func _physics_process(delta: float) -> void:
	follow_path()

func debug_forward_movement():
	self.position.x += 50

func run_away_from_light():
	run_away = true
	run_state = RunState.AWAY
	entity.rotation = player_pos.direction_to(position).angle()
	DebugTools.update_debug_label(debug_label, "I'm running away from the light")
	await DebugTools.set_timer(flee_time)
	run_away = false
	run_state = RunState.TOWARDS
	DebugTools.update_debug_label(debug_label, "I'm running towards the player")


func debug_backward_movement():
	self.position.x -= 50


func get_path_info() -> void:
	if pathfinder.line_path.is_empty():
		return
	player_path = pathfinder.line_path.get(1)
	var flip = pathfinder.line_path
	flip.reverse()
	player_pos = flip.get(1)


func follow_path() -> void:
	if pathfinder.line_path.is_empty():
		return
	get_path_info()
	global_position = global_position.move_toward(player_path, run_state)
	if not run_away:
		entity.look_at(player_pos)
