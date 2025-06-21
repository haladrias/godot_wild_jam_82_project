extends Control

@onready var title_sceen_musc: AudioStreamPlayer = $title_sceen_musc
@onready var button_sound: AudioStreamPlayer = $button_sound
@onready var enable_button_sound: CheckBox = $"settings_page/PanelContainer/MarginContainer/VBoxContainer/GridContainer/enable button sound"
@onready var enable_music: CheckBox = $"settings_page/PanelContainer/MarginContainer/VBoxContainer/GridContainer/enable music"



var is_playing : bool = true
var is_music_playing : bool = true

func _ready() -> void:
	%play.pressed.connect(play_pressed)
	%quit.pressed.connect(quit_game)
	enable_button_sound.pressed.connect(control_click_sound)
	enable_music.pressed.connect(control_music)
	pass

func play_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func control_click_sound():
	#if is_playing == true:
		#is_playing = false
	#elif is_playing == false:
		#is_playing = true
		#button_sound.stream_paused = false
	pass

func control_music():
	if is_music_playing == true:
		title_sceen_musc.stream_paused = true
		is_music_playing = false
	elif is_music_playing == false:
		title_sceen_musc.stream_paused = false
		is_music_playing = true


func quit_game():
	get_tree().quit()
