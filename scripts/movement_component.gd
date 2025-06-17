extends Node2D
class_name MovementComponent
@export_subgroup("Movement Settings")
@export var speed: int = 400
@export var amt_to_slow : int = 200.0
@export var parent : CharacterBody2D

func _ready() -> void:
	AilmentManager.entered.connect(apply_status_effect)
	AilmentManager.exited.connect(remove_status_effect)

func handle_movement(body: CharacterBody2D, direction: Vector2):
	body.velocity = direction.normalized() * speed
	direction = body.velocity


func apply_status_effect()-> void:
	#if AilmentManager.ailment == 1:
		#_slow()
	#elif AilmentManager.ailment == 2:
		#_stun()
		#remove_status_effect()
	
	match AilmentManager.target:
		1:#PLAYER
			if parent.is_in_group("Player"):
				if AilmentManager.ailment == 1:
					_slow()
				elif AilmentManager.ailment == 2:
					_stun()
					remove_status_effect()
		2:#ENEMY
			if parent.is_in_group("Enemy"):
				if AilmentManager.ailment == 1:
					_slow()
				elif AilmentManager.ailment == 2:
					_stun()
					remove_status_effect()
		_:
			print("target out of scope")


func remove_status_effect() -> void:
	if AilmentManager.ailment == 1:
		speed = 400
	elif AilmentManager.ailment == 2:
		await get_tree().create_timer(3).timeout
		speed = 400

func _slow() -> void:
	speed -= amt_to_slow
	pass

func _stun() -> void:
	await get_tree().create_timer(0.5).timeout
	speed = 0
	
	pass
