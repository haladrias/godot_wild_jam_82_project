extends Node2D
class_name MovementComponent
@export_subgroup("Movement Settings")
@export var speed: int = 400


func handle_movement(body: CharacterBody2D, direction: Vector2):
	body.velocity = direction.normalized() * speed
	direction = body.velocity
