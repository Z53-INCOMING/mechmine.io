extends RayCast2D

var is_casting := false setget set_is_casting

func _ready() -> void:
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	
	force_raycast_update()
	$collisionParticles.emitting = is_colliding()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$collisionParticles.global_rotation = get_collision_normal().angle()
		$collisionParticles.position = cast_point
		
		
		
	$Line2D.points[1] = cast_point
	$beamParticles.position = cast_point * 0.5
	$beamParticles.process_material.emission_box_extents.x = cast_point.length() * 0.5

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	$beamParticles.emitting = is_casting
	$"casting particles".emitting = is_casting
	if is_casting:
		appear()
	else:
		$collisionParticles.emitting = false
		disappear()
	set_physics_process(is_casting)

func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()
func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0.0, 0.2)
	$Tween.start()


func _on_Timer_timeout() -> void:
	if get_collider() is KinematicBody2D:
		var object = get_collider() as KinematicBody2D
#		object.health -= 1
