extends StaticBody2D


func _ready() -> void:
	pass


func _on_Area_body_entered(body: Node) -> void:
	queue_free()
