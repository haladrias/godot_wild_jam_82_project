extends Node2D

func _ready() -> void:
	SignalBus.debug_set_grid_size.connect(set_panel)

# For debug, we shoould remove it once we have a tilemap in place
func set_panel(size):
	$Panel.size = size
	print("The playable area is " + str($Panel.size) + ". Remain within the panel boundary for the pathing to work.")
