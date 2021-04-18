extends Camera2D




func _on_tank_die() -> void:
	current = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("zoom in"):
		zoom.x -= 0.1
	if Input.is_action_pressed("zoom out"):
		zoom.x += 0.1
	zoom.y = zoom.x

