extends Node2D

# This will be highest scene for the game

# Debug functionality to quit the game or reload the scene
# Press Q to quit the game
# Press CTRL + R to reload the current scene
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		print("Quitting game")
		get_tree().quit()
	if event.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("shift_space_bar"):
		SignalBus.debug_shift_spacebar_pressed.emit()
	if event.is_action_pressed("space_bar"):
		SignalBus.debug_spacebar_pressed.emit()

func _ready() -> void:
	SignalBus.portal_timer_completed.connect(on_portal_timer_completed)

func on_portal_timer_completed():
	# TODO: Change to win screen
	pass
