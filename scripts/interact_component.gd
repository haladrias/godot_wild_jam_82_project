class_name InteractComponent extends Area2D

@onready var interact_area: CollisionShape2D = $CollisionShape2D
@onready var interact_dialogue: RichTextLabel = $InteractDialogue
@export var interact_type: GlobalConstants.PowerType
@onready var old_parent: = get_parent().get_parent()

var get_interact_input = Input.is_action_just_pressed("ui_interact")
var can_pickup: bool = false

func _ready() -> void:
	SignalBus.pressed_interact.connect(_on_pressed_interact)
	await DebugTools.set_timer(.5)
	print(old_parent)
	print(get_parent())

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		can_pickup = true
		interact_dialogue.text = "Press " + str(get_interact_input) + " to pick up"
		interact_dialogue.show()



func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		can_pickup = false
		interact_dialogue.hide()

func reparent_to_player(p) -> void:
	if can_pickup:
		can_pickup = false
		get_parent().collision_layer = 0
		interact_area.disabled = true
		get_parent().reparent(p)


func unparent_from_player() -> void:
	can_pickup = true
	get_parent().collision_layer = 1
	interact_area.disabled = false
	get_parent().reparent(old_parent)

	print("Attempted to reparent to " + str(old_parent))


func _on_pressed_interact(player) -> void:
	if can_pickup:
		reparent_to_player(player)
	elif can_pickup == false:
		if get_parent().get_parent() == player:
			call_deferred("unparent_from_player")
			printerr("Drop it")
			print(old_parent)
