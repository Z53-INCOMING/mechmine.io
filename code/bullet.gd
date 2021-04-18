extends Area2D

var speed = Vector2.ZERO

var bullet_damage = 0
func _ready() -> void:
	position += Vector2(cos(rotation), sin(rotation)) * 40

func _process(delta: float) -> void:
	position += speed

	
func _on_Timer_timeout() -> void:
	queue_free()


func _on_bullet_body_entered(body: Node) -> void:
	queue_free()
