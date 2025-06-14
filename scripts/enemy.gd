extends CharacterBody2D
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var detection_component: DetectionComponent
@onready var debug_label: RichTextLabel = $DebugLabel
@onready var entity: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# detection_component.proximity_detection_triggered.connect(panic)
	pass

func _process(_delta):
	#detection_component.set_view_cone_rotation(input_component.get_mouse_location())
	#entity.look_at(input_component.get_mouse_location())
	#move_and_slide()
	return

func panic():
	DebugTools.update_debug_label(debug_label, "There is an enemy nearby!")
