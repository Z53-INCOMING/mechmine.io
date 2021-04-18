extends Node2D

var bullet_scene = preload("res://scenes/bullet.tscn")

onready var timer = $Timer

export var damage = 1.0

export var speed = 1.0

export var reload = 1.0

export var spread = 22.5

var bullet_damage = 0

var bullet_reload = 0

var bullet_speed = 0

func shoot():
	timer.wait_time = (1.1 - (bullet_reload * 0.1)) / reload
	if timer.time_left <= 0:
		var bullet = bullet_scene.instance()
		var main = get_tree().current_scene
		bullet.global_position = global_position
		bullet.rotation_degrees = global_rotation_degrees + rand_range(-spread, spread)
		bullet.speed = Vector2(cos(bullet.global_rotation), sin(bullet.global_rotation)) * speed * (bullet_speed + 1)
		bullet.modulate = modulate
		bullet.bullet_damage = (bullet_damage + 1) * damage
		main.add_child(bullet)
		timer.start()
