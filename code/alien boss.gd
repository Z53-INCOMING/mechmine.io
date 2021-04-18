extends KinematicBody2D
var past_range = false
var health = 2000
onready var mech = get_parent().find_node("tank")

onready var laser = $laser
onready var tentacle1 = $tentacle
onready var tentacle2 = $tentacle2
onready var tentacle3 = $tentacle3
onready var tentacle4 = $tentacle4


func _process(delta: float) -> void:
	var tentacleDistance1 = tentacle1.global_position.distance_to(mech.global_position)
	var tentacleDistance2 = tentacle2.global_position.distance_to(mech.global_position)
	var tentacleDistance3 = tentacle3.global_position.distance_to(mech.global_position)
	var tentacleDistance4 = tentacle4.global_position.distance_to(mech.global_position)
	laser.rotation = (mech.global_position - global_position).angle()
	if past_range != (position.distance_to(mech.position) < 1000.0):
		laser.is_casting = !laser.is_casting
	past_range = position.distance_to(mech.position) < 1000.0
	move_and_slide(Vector2.ZERO)
	if health <= 0:
		queue_free()
	if global_position.distance_to(mech.global_position) < 300:
		var tentacles = [tentacleDistance1, tentacleDistance2, tentacleDistance3, tentacleDistance4]
		
		match tentacles.find(tentacles.min()):
			0:
				$Tween.stop_all()
				$Tween.interpolate_property(tentacle1, "rotation", tentacle1.rotation, (mech.global_position - tentacle1.global_position).angle(), 0.2)
				$Tween.interpolate_property(tentacle2, "rotation", tentacle2.rotation, -45, 0.2)
				$Tween.interpolate_property(tentacle3, "rotation", tentacle3.rotation, 45, 0.2)
				$Tween.interpolate_property(tentacle4, "rotation", tentacle4.rotation, 135, 0.2)
				$Tween.start()
			1:
				$Tween.stop_all()
				$Tween.interpolate_property(tentacle2, "rotation", tentacle2.rotation, (mech.global_position - tentacle2.global_position).angle(), 0.2)
				$Tween.start()
			2:
				$Tween.stop_all()
				$Tween.interpolate_property(tentacle3, "rotation", tentacle3.rotation, (mech.global_position - tentacle3.global_position).angle(), 0.2)
				$Tween.start()
			3:
				$Tween.stop_all()
				$Tween.interpolate_property(tentacle4, "rotation", tentacle4.rotation, (mech.global_position - tentacle4.global_position).angle(), 0.2)
				$Tween.start()


func _on_Area2D_area_entered(area: Area2D) -> void:
	health -= area.bullet_damage + 1
