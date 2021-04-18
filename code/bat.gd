extends KinematicBody2D

var food_scene = preload("res://scenes/food.tscn")
var confetti_scene = preload("res://scenes/confetti.tscn")
var direction = 0

var health = 8

var strength = 100
var time = 0
var velocity = Vector2.ZERO
var directions = OpenSimplexNoise.new()
func _ready() -> void:
	randomize()
	
	directions.period = 256
	directions.octaves = 1
	directions.seed = rand_range(0, 1000)
	
func _process(delta: float) -> void:
	velocity.x = cos(direction) * strength
	velocity.y = sin(direction) * strength
	direction += deg2rad(((directions.get_noise_1d(time) * 2) - 1) * 2)
	velocity = move_and_slide(velocity)
	time += 1
	if health <= 0:
		var food = food_scene.instance()
		food.global_position = global_position
		food.from_bat = true
		var main = get_tree().current_scene
		main.add_child(food)
		var confetti = confetti_scene.instance()
		confetti.global_position = global_position
		main.add_child(confetti)
		queue_free()




func _on_Area2D_area_entered(area: Area2D) -> void:
	if not area.is_in_group("sensor"):
		health -= area.bullet_damage
