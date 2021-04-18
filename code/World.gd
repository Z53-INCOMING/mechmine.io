extends Node

func _ready() -> void:
	randomize()



func _on_Boulder_body_entered(body: Node) -> void:
	if body is Mech:
		var mech = body as Mech
		var boulder = $TileMap/Boulder
		boulder.apply_central_impulse(boulder.position.direction_to(mech.position) * 200)
