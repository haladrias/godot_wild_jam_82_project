@tool
extends Node2D
class_name DetectionComponent

signal view_cone_detection_triggered(body: PhysicsBody2D)
signal view_cone_detection_stopped(body: PhysicsBody2D)
## Proximity signals to be used for optimization; only begin rapid polling when entering the proximity area
# signal proximity_detection_triggered
# signal proximity_detection_stopped


@export var faction: GlobalConstants.FactionType
@onready var view_cone: Area2D = $ViewCone
@onready var proximity_area: Area2D = $ProximityArea
@onready var collision_polygon_2d: CollisionPolygon2D = $ViewCone/CollisionPolygon2D

# This dictionary will store the bodies we are currently detecting in our FOV.
# We use a dictionary for fast lookups. The value can be `true` or the body itself.
var _bodies_in_fov: Dictionary = {}


@export_group("ViewCone Properties")
@export var cone_resolution: int = 5:
	set(value):
		cone_resolution = max(value, 3)
		if is_node_ready():
			set_view_cone_polygon()

@export_range(100.0, 1000.0, 50.0) var cone_radius: float = 300.0:
	set(value):
		cone_radius = value
		if is_node_ready():
			set_view_cone_polygon()

## The angle of the cone in degrees. NOTE: max value is 300. Default 90, min 5.
@export_range(5.0, 300.0, 5.0) var cone_angle: float = 90.0:
	set(value):
		cone_angle = clamp(value, 20.0, 300.0)
		if is_node_ready():
			set_view_cone_polygon()


func _physics_process(_delta: float) -> void:
	# TODO: Optimize by adding logic to only run view_cone_detection() when an entity is in the proximity area
	view_cone_detection()


func view_cone_detection():
	# Ignore logic if the game is running in the editor
	if Engine.is_editor_hint():
		return

	# This dictionary will hold all bodies that are valid targets THIS frame.
	var current_bodies_in_fov: Dictionary = {}

	# Get all bodies currently inside the cone's physical Area2D shape.
	var overlapping_bodies = view_cone.get_overlapping_bodies()

	# Loop through them and perform FOV check.
	for body in overlapping_bodies:
		#? Add a check to filter by faction or group membership
		var direction_to_target = global_position.direction_to(body.global_position)
		var forward_vector = global_transform.x
		var facing_ratio = forward_vector.dot(direction_to_target)
		var fov_ratio = cos(deg_to_rad(cone_angle / 2.0))
		# If the body passes the FOV check, add it to the list of current detections.
		if facing_ratio > fov_ratio:
			current_bodies_in_fov[body] = true

	# Check for newly detected bodies
	for body in current_bodies_in_fov:
		if not _bodies_in_fov.has(body):
			# New detection if body is in the current list but wasn't in the previous frame's.
			print("NEW DETECTION: ", body.name)
			view_cone_detection_triggered.emit(body)
			#if body.is_in_group("Enemy"):
				#body.run_away_from_light()

	# Check for lost bodies
	for body in _bodies_in_fov:
		if not current_bodies_in_fov.has(body):
			print("LOST SIGHT OF: ", body.name)
			view_cone_detection_stopped.emit(body)

	# Update state for the next frame.
	_bodies_in_fov = current_bodies_in_fov


func _ready() -> void:
	set_view_cone_polygon()
	set_faction_groups()


func set_view_cone_polygon():
	if not is_node_ready():
		return
	var polygon_points: Array[Vector2] = [Vector2.ZERO]
	var cone_angle_rad = deg_to_rad(cone_angle)
	var cone_start_angle_rad = -cone_angle_rad / 2.0
	var step_rad = cone_angle_rad / cone_resolution
	for i in range(cone_resolution + 1):
		var current_angle = cone_start_angle_rad + i * step_rad
		var point = Vector2.from_angle(current_angle) * cone_radius
		polygon_points.append(point)
	collision_polygon_2d.polygon = polygon_points


func set_faction_groups():
	# Can use this to filter out bodies based on factions defined in GlobalConstants.gd (based on group membership)
	match faction:
		GlobalConstants.FactionType.Player:
			view_cone.add_to_group("PlayerDetector")
			proximity_area.add_to_group("PlayerDetector")
		GlobalConstants.FactionType.Enemy:
			view_cone.add_to_group("EnemyDetector")
			proximity_area.add_to_group("EnemyDetector")
