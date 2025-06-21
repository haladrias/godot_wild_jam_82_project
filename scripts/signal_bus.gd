extends Node

signal player_entered_portal # Can be used to kick off UI changes, enemy behaviour, rescue timerq
signal player_exited_portal
signal portal_timer_completed
signal player_position_changed
signal pressed_interact

## Debugging signals
signal debug_spacebar_pressed
