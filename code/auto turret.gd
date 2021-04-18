extends Node2D

var bullet_scene = preload("res://scenes/bullet.tscn")

onready var timer = $Timer
var rot = 0
export var intelligence = 3
var frame = false
export var reload = 1.0
var bullet_reload = 0
export var turn_speed = 5
var bullet_damage = 0
export var speed = 1.0
var bullet_speed = 0
export var damage = 1.0
export var view_radius = 250
func shoot():
	timer.wait_time = (1.1 - (bullet_reload * 0.1)) / reload
	if timer.time_left <= 0:
		
		var bullet = bullet_scene.instance()
		var main = get_tree().current_scene
		bullet.global_position = global_position
		bullet.rotation = global_rotation
		bullet.speed = Vector2(cos(global_rotation), sin(global_rotation)) * speed * (bullet_speed + 3)
		bullet.modulate = modulate
		bullet.bullet_damage = (bullet_damage + 1) * damage
		
		main.add_child(bullet)
		timer.start()
func _process(delta: float) -> void:
	global_rotation = rot
	if visible:
		frame = !frame
		if frame:
			$Area2D/CollisionShape2D.shape.radius = 0
		else:
			$Area2D/CollisionShape2D.shape.radius = view_radius
			update()


func _on_Area2D_body_entered(body: Node) -> void:
	rot = Vector2(body.global_position - global_position).angle()
