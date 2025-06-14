extends CharacterBody2D
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var detection_component: DetectionComponent
@onready var debug_label: RichTextLabel = $DebugLabel
@onready var entity: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	detection_component.proximity_detection_triggered.connect(detected)
	detection_component.proximity_detection_stopped.connect(not_detected)
	DebugTools.update_debug_label(debug_label, "I don't see anything")


func _process(_delta):
	movement_component.handle_movement(self, input_component.get_input_direction())
	detection_component.set_view_cone_rotation(input_component.get_mouse_location())
	entity.look_at(input_component.get_mouse_location())
	move_and_slide()
	return


func detected(area):
	if area.is_in_group("Enemy"):
		DebugTools.update_debug_label(debug_label, "There is an enemy nearby!")
	if area.is_in_group("Portal"):
		DebugTools.update_debug_label(debug_label, "I need to stay here to activate the portal!")


func not_detected(area):
	if area.is_in_group("Enemy"):
		DebugTools.update_debug_label(debug_label, "I think I lost them...")
