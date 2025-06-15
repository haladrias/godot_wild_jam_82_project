@tool
extends Node2D
class_name DetectionComponent
signal proximity_detection_triggered
signal proximity_detection_stopped
signal view_cone_detection_triggered
signal view_cone_detection_stopped


@export var faction: GlobalConstants.FactionType
@onready var debug_label: RichTextLabel = $DebugLabel
@onready var view_cone: Area2D = $ViewCone
@onready var proximity_area: Area2D = $ProximityArea
@onready var is_detecting: bool = false
@onready var collision_polygon_2d: CollisionPolygon2D = $ViewCone/CollisionPolygon2D
var cone_direction: Vector2

@export_group("ViewCone Properties")
@export var cone_resolution: int = 20:
	set(value):
		cone_resolution = max(value, 3)
		if is_node_ready():
			set_view_cone_polygon()
			print("Cone resolution updated to: " + str(cone_resolution))

@export_range(100.0, 1000.0, 50.0) var cone_radius: float = 300.0:
	set(value):
		cone_radius = value
		# If the node is ready, update the shape.
		if is_node_ready():
			set_view_cone_polygon()
			print("Cone length updated to: " + str(cone_radius))

@export_range(5.0, 360.0, 5.0) var cone_angle: float = 90.0:
	set(value):
		cone_angle = clamp(value, 20.0, 360.0)
		# If the node is ready, update the shape.
		if is_node_ready():
			set_view_cone_polygon()
			print("Cone angle updated to: " + str(cone_angle))



func _ready() -> void:
	set_view_cone_polygon()
	set_faction_groups()


func set_faction_groups():
	match faction:
		GlobalConstants.FactionType.Player:
			view_cone.add_to_group("PlayerDetector")
			proximity_area.add_to_group("PlayerDetector")
		GlobalConstants.FactionType.Enemy:
			view_cone.add_to_group("EnemyDetector")
			proximity_area.add_to_group("EnemyDetector")



func set_view_cone_polygon():
# This function uses cone_radius and cone_angle to create a polygon to use as the view cone collider.
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


func set_view_cone_rotation(direction):
	look_at(direction)
	cone_direction = direction


func view_cone_detected(area: Area2D):
	# TODO: Trigger seen behaviour
	is_detecting = true
	var direction = global_position.direction_to(area.global_position)
	var facing_ratio = cone_direction.dot(direction)
	var fov_ratio = cos(deg_to_rad(70))
	if facing_ratio > fov_ratio:
		match faction:
			GlobalConstants.FactionType.Player:
				if area.is_in_group("Enemy"):
					DebugTools.update_debug_label(debug_label,"Enemy detected")
					view_cone_detection_triggered.emit(area, is_detecting)
			GlobalConstants.FactionType.Enemy:
				if area.is_in_group("Player"):
					print("Player detected")
					view_cone_detection_triggered.emit(area, is_detecting)
	else:
		print("Not in field of vision")


func view_cone_no_longer_detected(area: Area2D):
	is_detecting = false
	if area.is_in_group("Enemy"):
		view_cone_detection_stopped.emit(area, is_detecting)
		DebugTools.update_debug_label(debug_label,"Enemy lost")


func proximity_detected(area: Area2D):
	is_detecting = true
	proximity_detection_triggered.emit(area, is_detecting)


func proximity_no_longer_detected(area: Area2D):
	is_detecting = false
	proximity_detection_stopped.emit(area, is_detecting)
