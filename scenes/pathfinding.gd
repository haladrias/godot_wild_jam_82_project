class_name Pathfinder extends Node2D
@export var cell_size = Vector2i(16, 16)

var astar_grid = AStarGrid2D.new()
var grid_size
var end = Vector2i(0, 0) # Placeholder, gets updated by player position signal
var entity_position = Vector2i.ZERO # Placeholder, gets updated by calling entity position
const GRID_ORIGIN = Vector2i(0, 0)
var line_path: PackedVector2Array # Will store the path to be drawn, probably useful to feed to movement_component to drive enemy movement

func _ready():
	SignalBus.player_position_changed.connect(update_end)
	get_tree().root.size_changed.connect(initialize_grid)
	initialize_grid()
	update_path()


func update_entity_position(pos):
	entity_position = Vector2i(Vector2i(pos) / cell_size)
	$Line2D.global_position = Vector2(0,0)


func initialize_grid():
	global_position = Vector2(0,0)
	grid_size = Vector2i(get_viewport_rect().size)
	astar_grid.region.position = GRID_ORIGIN
	astar_grid.region.size = grid_size
	astar_grid.cell_size = cell_size
	astar_grid.offset = cell_size / 2
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.update()


func update_end(pos):
	# Trigged by player position signal
	end = Vector2i(Vector2i(pos) / cell_size)


func update_path():
	line_path = PackedVector2Array(astar_grid.get_point_path(entity_position, end))
	$Line2D.points = line_path
