extends Node2D
class_name Slow

var max_time : float = 10.0
var _timer : float = 10.0
var parent : Node2D
var ailment_active : bool = false

@export var slowed  = 0.5
@export var normal_speed = 400
@export var movement : Node2D

func _ready() -> void:
	#parent = get_parent().get_node("res://scenes/movement_component.tscn")
	AilmentTrigger.player_entered.connect(apply)
	#AilmentTrigger.player_exited.connect(remove)
	

func _process(_delta: float) -> void:
	if ailment_active == false:
		return
	if _timer <= 0:
		remove()
		return
	_timer -= _delta
	
	print(_timer)

func apply() -> void:
	if movement.speed <= 200:
		return
	movement.speed -= 200
	ailment_active = true
	print("slowed")
	pass



func remove() -> void:
	movement.speed = normal_speed
	_timer = max_time
	ailment_active = false
	print("slow removed")
	pass
