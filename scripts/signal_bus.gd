extends Node

signal player_entered_portal # Can be used to kick off UI changes, enemy behaviour, rescue timerq
signal player_exited_portal
signal portal_timer_completed
signal player_position_changed

## Debugging signals
signal debug_spacebar_pressed
signal debug_set_grid_size # Signals game.gd to update the panel size to indicate grid size
