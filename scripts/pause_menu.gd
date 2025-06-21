extends CanvasLayer

@onready var resume: Button = $Control/CenterContainer/VBoxContainer/resume
@onready var settings: Button = $Control/CenterContainer/VBoxContainer/settings
@onready var quit_to_title: Button = $"Control/CenterContainer/VBoxContainer/quit to title"

var is_paused : bool = false

func _ready() -> void:
	hide_pause_menu()
	resume.pressed.connect(hide_pause_menu)
	quit_to_title.pressed.connect(on_quit_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu()-> void:
	get_tree().paused = true
	visible = true
	is_paused = true

func hide_pause_menu()-> void:
	get_tree().paused = false
	visible = false
	is_paused = false

func on_quit_pressed() -> void:
	get_tree().paused = false
	hide_pause_menu()
	await get_tree().process_frame
	
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
