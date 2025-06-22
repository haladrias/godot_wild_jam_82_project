extends Node

signal player_entered_portal # Can be used to kick off UI changes, enemy behaviour, rescue timerq
signal player_exited_portal
signal portal_timer_completed
signal player_position_changed

## Debugging signals
signal debug_spacebar_pressed
signal debug_shift_spacebar_pressed
signal debug_set_grid_size # Signals game.gd to update the panel size to indicate grid size

## Power management signals
signal battery_in_charger
func battery_connected_to_charger() -> void:
	battery_in_charger.emit()

signal battery_in_consumer
func battery_connected_to_consumer() -> void:
	battery_in_consumer.emit()



#? Consider refactoring to remove those annoying warnings that the signals were declared but not used
#? This has an additional benefit of being able to enforce variable type

#? The calling script would call this function instead of the signal
#? So from the calling script:

#func do_something() -> void:
	#SignalBus.did_something()

#? From the SignalBus:
#signal did_something
#func emit_did_something(something: Something) -> void:
	#did_something.emit()
