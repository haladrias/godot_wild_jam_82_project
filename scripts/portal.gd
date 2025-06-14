extends Node2D

@onready var rescue_timer: Timer = $RescueTimer
@onready var rescue_label: RichTextLabel = $RescueLabel
@onready var debug_label: RichTextLabel = $DebugLabel
@export var rescue_timer_duration: float = 2.0


func _process(_delta: float) -> void:
	if rescue_timer != null:
		if rescue_timer.time_left > 0:
			update_rescue_label(rescue_timer.time_left)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	SignalBus.player_entered_portal.emit()
	if area.is_in_group("Player"):
		start_rescue_timer()
		update_debug_label("Player entered portal")
	pass


func start_rescue_timer():
	rescue_label.show()
	update_debug_label("Rescue timer started")
	rescue_timer.start(rescue_timer_duration)


func stop_rescue_timer():
	rescue_label.hide()
	if rescue_timer.time_left > 0:
		rescue_timer.stop()


func update_rescue_label(time_left: float) -> void:
	rescue_label.text = "Time remaining: " + str(snappedf(time_left, 0.1))


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if rescue_timer != null:
			stop_rescue_timer()
			update_debug_label("Timer has been reset because player left portal")
		update_debug_label("Player left portal")



func _on_rescue_timer_timeout() -> void:
	stop_rescue_timer()
	SignalBus.portal_timer_completed.emit()
	update_debug_label("Rescue timer finished; you win!")

func update_debug_label(text: String) -> void:
	debug_label.text = text
