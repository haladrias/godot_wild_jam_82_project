extends Area2D
class_name slow_zone

@export_category("ailment and target")
@export var status_ailment : int = 1
@export var target : int#1 is player, 2 is enemy

func _ready() -> void:
	AilmentManager.ailment = status_ailment
	AilmentManager.target = target
	#pass
#
func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body. is_in_group("Player"):
		AilmentManager.entered.emit()
		print("entered")
	pass


func _on_area_2d_area_exited(body : CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		AilmentManager.exited.emit()
	pass
