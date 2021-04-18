extends Area2D
signal tutorial_complete
func _on_Area2D_body_entered(body: Node) -> void:
	emit_signal("tutorial_complete")
