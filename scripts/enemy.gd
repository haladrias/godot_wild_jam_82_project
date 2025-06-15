extends CharacterBody2D
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var detection_component: DetectionComponent
@onready var debug_label: RichTextLabel = $DebugLabel
@onready var entity: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	#detection_component.proximity_detection_triggered.connect(panic)
	detection_component.view_cone_detection_triggered.connect(was_detected)
	detection_component.view_cone_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")
	pass

func _process(_delta):
	#detection_component.set_view_cone_rotation(input_component.get_mouse_location())
	#entity.look_at(input_component.get_mouse_location())
	#move_and_slide()
	return

func was_detected(_area: Area2D, is_detecting: bool):
	if is_detecting:
		DebugTools.update_debug_label(debug_label, "I've been seen!")


func not_detected(_area: Area2D, is_detecting: bool):
	if !is_detecting:
		DebugTools.update_debug_label(debug_label, "I'm no longer seen!")
