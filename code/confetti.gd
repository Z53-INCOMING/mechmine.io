extends Particles2D


func _ready() -> void:
	emitting = true


func _on_Timer_timeout() -> void:
	queue_free()
