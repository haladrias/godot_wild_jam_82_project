class_name Pathfinder extends Node2D
@export var cell_size = Vector2i(64, 64)

var astar_grid = AStarGrid2D.new()
var grid_size
var end = Vector2i(5, 5) # Placeholder, gets updated by player position signal
var entity_position = Vector2i.ZERO # Placeholder, gets updated by calling entity position

func _ready():
	SignalBus.player_position_changed.connect(update_end)
	get_tree().root.size_changed.connect(initialize_grid)
	initialize_grid()
	update_path()


func update_entity_position(pos):
	entity_position = Vector2i(Vector2i(pos) / cell_size)

func initialize_grid():
	global_position = Vector2(0,0)
	grid_size = Vector2i(get_viewport_rect().size)
	astar_grid.region.position = Vector2i(0,0)
	astar_grid.region.size = grid_size
	astar_grid.cell_size = cell_size
	astar_grid.offset = cell_size / 2
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.update()


func update_end(pos):
	# Trigged by player position signal
	end = Vector2i(Vector2i(pos) / cell_size)


func update_path():
	#! The bug is in here? Somewhere along the way the position is drifting
	#! Duplicate by dragging the enemy in the game scene while debugging, the line will start to drift when rendering
	# print(astar_grid.is_dirty())
	$Line2D.points = PackedVector2Array(astar_grid.get_point_path(entity_position, end))
	$Line2D.global_position = entity_position
	print("Line global pos: " + str($Line2D.global_position))
	print ("Entity position: " + str(entity_position))
func _draw():
	# draw_grid()
	pass


func draw_grid():
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0), Vector2(x * cell_size.x, grid_size.y * cell_size.y), Color.DARK_GRAY, 2.0)
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y), Vector2(grid_size.x * cell_size.x, y * cell_size.y), Color.DARK_GRAY, 2.0)
