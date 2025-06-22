class_name Entity extends CharacterBody2D
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var detection_component: DetectionComponent
@onready var debug_label: RichTextLabel = $DebugLabel
@onready var entity: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	detection_component.view_cone_detection_triggered.connect(detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")


func detected(body):
	DebugTools.update_debug_label(debug_label, "I detected a " + body.name)


func not_detected(body):
	DebugTools.update_debug_label(debug_label, "I think I lost " + body.name)
