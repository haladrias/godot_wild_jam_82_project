extends Control

@onready var title_sceen_musc: AudioStreamPlayer = $title_sceen_musc
@onready var button_sound: AudioStreamPlayer = $button_sound
@onready var enable_button_sound: CheckBox = $"settings/PanelContainer/MarginContainer/VBoxContainer/GridContainer/enable button sound"
@onready var enable_music: CheckBox = $"settings/PanelContainer/MarginContainer/VBoxContainer/GridContainer/enable music"





func _ready() -> void:
	%play.pressed.connect(play_pressed)
	%quit.pressed.connect(quit_game)
	
	pass

func play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func quit_game():
	get_tree().quit()
