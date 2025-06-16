extends Node2D

signal player_entered
signal player_exited
signal enemy_entered
signal enemy_exited

@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	
	pass

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		player_entered.emit()
	else:
		enemy_entered.emit()
	


#func _on_area_2d_area_exited(body : CharacterBody2D) -> void:
	#if body.is_in_group("Player"):
		#player_exited.emit()
	#else:
		#enemy_exited.emit()
