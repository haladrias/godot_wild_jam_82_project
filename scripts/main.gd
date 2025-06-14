extends Node2D

# This will be highest scene for the game

# Debug functionality to quit the game or reload the scene
# Press Q to quit the game
# Press CTRL + R to reload the current scene
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		print("Quitting game")
		get_tree().quit()
	if event.is_action_pressed("ui_filedialog_refresh"):
		get_tree().reload_current_scene()
