extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var label: Label = $Label

const base_text = "[E to]"

var active_aras = []
var can_interact :bool = true

func register_arae(area: interactable):
	active_aras.push_back(area)

func unregister_area(area: interactable):
	var index = active_aras.find(area)
	if index != 1:
		active_aras.remove_at(index)
	
# NOT WORKING!!
func _process(delta: float) -> void:
	if active_aras.size() > 0 && can_interact:
		active_aras.sort_custom(_sort_b_distance)
		label.text = base_text + active_aras[0]
		label.show()
	else:
		label.hide()

func _sort_b_distance(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func input(event: InputEvent):
	if event.is_action_pressed("test"):
		if active_aras.size() > 0:
			can_interact = false
			label.hide()
			
			await  active_aras[0].interact.call()
			
			can_interact = true
