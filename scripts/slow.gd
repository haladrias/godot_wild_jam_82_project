extends Area2D
class_name Slow

var max_time : float = 3.0
var _timer : float = 3.0
var parent : CharacterBody2D
var ailment_active : bool = false

@export var slowed  = 0.5
@export var normal_speed = 400
@export var movement : Node2D

func _ready() -> void:
	parent = get_parent()
	#AilmentTrigger.player_entered.connect(apply)
	#AilmentTrigger.player_exited.connect(remove)
	pass

func _process(_delta: float) -> void:
	if ailment_active == false:
		return
	if _timer <= 0:
		remove_stun()
		return
	_timer -= _delta
	
	print(_timer)

func apply_slow() -> void:
	if movement.speed <= 200:
		return
	movement.speed -= 200
	#ailment_active = true
	print("slowed")
	pass

func apply_stun()-> void:
	movement.speed = 0
	ailment_active = true

func remove() -> void:
	movement.speed = normal_speed
	
	ailment_active = false
	print("slow removed")
	pass

func remove_stun() -> void:
	movement.speed = normal_speed
	_timer = max_time
	ailment_active = false
	pass

func _on_area_entered(area: trigger) -> void:
	if area is trigger:
		if AilmentManager.ailment == 1:
			apply_slow()
		elif AilmentManager.ailment == 2:
			await get_tree().create_timer(0.5).timeout
			apply_stun()


func _on_area_exited(_area: trigger) -> void:
	if _area is trigger:
		remove()
