extends Node2D

var player_is_present: bool = false



func _on_area_2d_area_entered(area: Area2D) -> void:
	SignalBus.player_entered_portal.emit()
	if area.is_in_group("Player"):
		player_is_present = true
		print("Player entered portal")

	# TODO: Start a timer that resets if the player leaves the portal area
	pass
