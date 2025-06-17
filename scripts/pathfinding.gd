class_name Pathfinder extends Node2D

@export_group("AStar Grid Properties")
@export var cell_size = Vector2i(16, 16)
## Grid size is based on number of cells, not pixels. Grid size in pixels will be grid_size * cell_size
@export var grid_size = Vector2i(200, 200)
@export var show_grid: bool = false
# TODO: Rework these vars to allow entry as pixels and have the script convert to cell units

var astar_grid = AStarGrid2D.new()
var end = Vector2i(0, 0) # Placeholder, gets updated by player position signal
var entity_position = Vector2i.ZERO # Placeholder, gets updated by calling entity position
const GRID_ORIGIN = Vector2i(0, 0)
var line_path: PackedVector2Array # Will store the path to be drawn, probably useful to feed to movement_component to drive enemy movement

func _ready():
	SignalBus.player_position_changed.connect(update_end)
	get_tree().root.size_changed.connect(initialize_grid)
	initialize_grid()
	update_path()
	## Timer is used to ensure that the signal is connected and the Panel is ready before the signal is emitted
	await get_tree().create_timer(0.2).timeout
	SignalBus.debug_set_grid_size.emit(Vector2(grid_size * cell_size))

func update_entity_position(pos):
	entity_position = Vector2i(Vector2i(pos) / cell_size)
	$Line2D.global_position = Vector2(0,0)

func initialize_grid():
	global_position = Vector2(0,0)
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

func _draw():
	if show_grid:
		draw_grid() # is only needed to show debug grid
	pass

func draw_grid():
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0), Vector2(x * cell_size.x, grid_size.y * cell_size.y), Color(.6,.6,.6,.2), 2.0)
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y), Vector2(grid_size.x * cell_size.x, y * cell_size.y), Color(.6,.6,.6,.2), 2.0)
