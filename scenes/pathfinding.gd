extends Node2D

## variables to help define the characteristics of the Astar navigation
## this variable *should* start the Astar 
var astar = AStarGrid2D.new()
## thsese two variables will the beginning and end of the Astar navigation, i hope 
var pathfinding_start = Vector2i(5,5)
var pathfinding_end = Vector2i(25,15)
## this *should* control the grid size; i hope it is redundant
var grid_size
@export var cell_size = Vector2i(64,64)

## function to load the primary functions of the pathfinding
func _ready():
	initialize_grid()
	update_path()

## this function *should* begin the grid the Astar will use for navigation;
## i am not sure we even need this function
func initialize_grid():
	## this controls the grid size that the Astar will use
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	astar.size = grid_size
	## this should control the cell size, i hope i got it right
	astar.cell_size = cell_size
	astar.offset = cell_size / 2
	
	## im keeping these two lines in and have them commented just in case they are needed.
	## This will keep the lines the pathfinder Astar will create from being straight, i hope we wont need to use it
	#astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	## this controls the type of line we get; 
	## in short it changes the algorithm the engine uses to draw a line from point to point;
	#astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	## this one *should* have it update as the algorithm gets used.
	astar.update()

## this *should* create and update the path between two points
## also this is used for debugging purposes, as it *should* create a line between the two points
func update_path():
	$Line2D.points = PackedVector2Array(astar.get_point_path(pathfinding_start, pathfinding_end))
