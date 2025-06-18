extends Node

func update_debug_label(label: RichTextLabel, text):
	label.text = text

func set_timer(time: float):
	await get_tree().create_timer(time).timeout