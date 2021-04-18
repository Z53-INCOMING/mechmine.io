extends Node2D

export var force = 3
onready var fire = get_parent().get_parent().get_node("fire")

func thrust():
	fire.emitting = true
	return Vector2(cos(global_rotation), sin(global_rotation)) * force

func stop_thrust():
	fire.emitting = false
	
