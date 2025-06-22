extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	SignalBus.debug_set_grid_size.connect(set_panel)
	audio_player.play()
	PauseMenu.music_stop.connect(background_music_stop)
	PauseMenu.music_playing.connect(background_music_play)

# For debug, we shoould remove it once we have a tilemap in place
func set_panel(size):
	$Panel.size = size
	print("The playable area is " + str($Panel.size) + ". Remain within the panel boundary for the pathing to work.")

func background_music_stop() -> void:
	if PauseMenu.is_playing == false:
		audio_player.stop()
		print("method called")
	pass

func background_music_play() -> void:
	if PauseMenu.is_playing == true:
		audio_player.play()
