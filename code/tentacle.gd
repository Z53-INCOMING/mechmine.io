extends Node2D
onready var seg2 = $"tentacle piece2"

onready var seg3 = $"tentacle piece2/tentacle piece/Node2D"

onready var seg4 = $"tentacle piece2/tentacle piece/Node2D/tentacle piece2/Node2D"

onready var seg5 = $"tentacle piece2/tentacle piece/Node2D/tentacle piece2/Node2D/tentacle piece3/Node2D"
var original_rotation = rotation
func _process(delta: float) -> void:
	seg2.rotation = rotation - original_rotation
	seg3.rotation = rotation - original_rotation
	seg4.rotation = rotation - original_rotation
	seg5.rotation = rotation - original_rotation
	
