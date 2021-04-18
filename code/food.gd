extends Node2D

var from_bat = false

onready var e = $"up and down"

func _ready() -> void:
	e.play("up and down")

func _on_Area2D_body_entered(body: Node) -> void:
	body.food += 15
	if from_bat:
		body.XP += 99
	queue_free()
