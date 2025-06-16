extends Area2D
class_name interactable


@export var interact_name : String = ""
@export var is_interactable : bool = true

var interactable : Callable = func():
	pass
	



func _on_area_entered(area: Area2D) -> void:
	InteracatingComponent.register_arae(self)
	pass


func _on_area_exited(area: Area2D) -> void:
	InteracatingComponent.unregister_area(self)
