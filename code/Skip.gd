extends Button

onready var portal = $Area2D

func _on_Skip_button_down() -> void:
	visible = false
	portal.emit_signal("tutorial_complete")
