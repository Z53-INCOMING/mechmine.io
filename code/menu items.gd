extends Node2D

func _ready() -> void:
	visible = false

func _on_menu_button_down() -> void:
	visible = !visible
