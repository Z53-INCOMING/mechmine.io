extends Area2D

func _on_stat_coin_body_entered(body: Node) -> void:
	body.stat_coins += 1
	queue_free()
