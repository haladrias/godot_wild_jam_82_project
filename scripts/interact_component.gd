class_name InteractComponent extends Area2D

@onready var interact_area: CollisionShape2D = $CollisionShape2D
@onready var interact_dialogue: RichTextLabel = $InteractDialogue
@export var interact_type: GlobalConstants.PowerType
@onready var game_node: = get_parent().get_parent()
@onready var parent:= get_parent()
## How far the item is place when unheld
@export var item_throw_distance: int = 75
@export var power_type: GlobalConstants.PowerType

var get_interact_input = InputMap.action_get_events("ui_interact")[0].as_text()
var can_pickup: bool = false

func _ready() -> void:
	SignalBus.pressed_interact.connect(_on_pressed_interact)
	await DebugTools.set_timer(.5)
	interact_dialogue.text = "Press " + str(get_interact_input) + " to pick up"
	match power_type:
		GlobalConstants.PowerType.SOURCE:
			print("Power Source")
			add_to_group("PowerSource")
		_:
			printerr("Invalid power type")
	# print(InputMap.action_get_events("ui_interact"))
	# var key_event = InputMap.action_get_events("ui_interact")[0].as_text()
	# print(key_event)
	# get_action_list("ui_interact"))

# TODO: Add a check using get_overlapping_bodies() to pick closest interactable item. Currently will grab everything in range
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		can_pickup = true
		interact_dialogue.text = "Press " + str(get_interact_input) + " to pick up"
		interact_dialogue.show()



func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		can_pickup = false
		interact_dialogue.hide()


## Reparents the item to the player
func reparent_to_player(p) -> void:
	var overlap = self.get_overlapping_bodies()
	for body in overlap:
		if body is Player:
			if can_pickup:
				can_pickup = false
				get_parent().collision_layer = 0
				interact_area.disabled = true
				# monitoring = false
				parent.reparent(p)
				parent.global_position = p.global_position


## Reparents the item to the game scene
func unparent_from_player() -> void:
	can_pickup = true
	parent.collision_layer = 1
	interact_area.disabled = false
	# monitoring = true
	parent.position = parent.position + Vector2(item_throw_distance, 0)
	parent.reparent(game_node) # Puts the item on the ground
	parent.rotation = 0


func _on_pressed_interact(player) -> void:
	if can_pickup:
		reparent_to_player(player)
	elif can_pickup == false:
		if get_parent().get_parent() == player:
			call_deferred("unparent_from_player")
