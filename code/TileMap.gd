extends TileMap
var food_scene = preload("res://scenes/food.tscn")
var bat_scene = preload("res://scenes/bat.tscn")
var coin_scene = preload("res://scenes/stat coin.tscn")
var shelter_scene = preload("res://scenes/shelter.tscn")
onready var mech = get_node("player")

var has_moved = false
var positions = []
var mech_position
var last_direction = Vector2.ZERO
func _ready() -> void:
	randomize()
	var caves = OpenSimplexNoise.new()
	caves.seed = rand_range(0, 10000)
	caves.period = 5
	caves.octaves = 1
	
	var cave_density = OpenSimplexNoise.new()
	cave_density.seed = rand_range(0, 10000)
	cave_density.period = 100
	cave_density.octaves = 1
	for x in range(-500, 0):
		for y in range(-500, 0):
			set_cell(x, y, 0, rand_bool(), rand_bool(), false, Vector2(2, 0))
			
			if round(rand_range(1, 5)) == 1:
				set_cell(x, y, 0, rand_bool(), rand_bool(), false, Vector2(1, 0))
				if round(rand_range(1, 4)) != 1:
					set_cell(x + rand_range(-1, 1), y + rand_range(-1, 1), 0, rand_bool(), rand_bool(), false, Vector2(1, 0))
			if round(rand_range(1, 15)) == 1:
				set_cell(x, y, 0, rand_bool(), rand_bool(), false, Vector2(3, 0))
				last_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
				var x2 = last_direction.x
				var y2 = last_direction.y
				if round(rand_range(1, 6)) != 1:
					for z in range(1, rand_range(5, 10)):
						
						var change = Vector2(rand_range(-1, 1), rand_range(-1, 1))
						if change == last_direction:
							change = Vector2(rand_range(-1, 1), rand_range(-1, 1))
						if change == last_direction:
							change = Vector2(rand_range(-1, 1), rand_range(-1, 1))
						if change == last_direction:
							change = Vector2(rand_range(-1, 1), rand_range(-1, 1))
						x2 += change.x
						y2 += change.y
						set_cell(x2, y2, 0, rand_bool(), rand_bool(), false, Vector2(3, 0))
			if round(rand_range(1, 50)) == 1:
				set_cell(x, y, 0, rand_bool(), rand_bool(), false, Vector2(4, 0))
				if round(rand_range(1, 5)) == 1:
					set_cell(x + rand_range(-1, 1), y + rand_range(-1, 1), 0, rand_bool(), rand_bool(), false, Vector2(4, 0))
			if caves.get_noise_2d(x, y) < cave_density.get_noise_2d(x, y):
				set_cell(x, y, -1)
				if round(rand_range(1, 100)) == 1:
					positions.append(Vector2(x * 50, y * 50))

	for x in range(-501, 0):
		set_cell(x, -501, 0,  rand_bool(), rand_bool(), false, Vector2(0, 0))
	for x in range(-501, 0):
		set_cell(x, 0, 0, rand_bool(), rand_bool(), false, Vector2(0, 0))
	for y in range(-501, 0):
		set_cell(-501, y, 0, rand_bool(), rand_bool(), false, Vector2(0, 0))
	for y in range(-501, 0):
		set_cell(0, y, 0, rand_bool(), rand_bool(), false, Vector2(0, 0))
	positions.shuffle()
	mech_position = positions[0]
	
	positions.pop_front()
	for pos in positions:
		var random = round(rand_range(1, 6))
		if random == 1 or random == 2 or random == 3:
			var bat = bat_scene.instance()
			bat.global_position = pos
			add_child(bat)
			var food = food_scene.instance()
			food.global_position = pos
			add_child(food)
		if random == 4 or random == 5:
			var coin = coin_scene.instance()
			coin.global_position = pos
			add_child(coin)
		if random == 6:
			var shelter = shelter_scene.instance()
			shelter.global_position = pos
			shelter.rotation_degrees = rand_range(-180, 180)
			add_child(shelter)
	positions.shuffle()

	

	
func rand_bool():
	return round(rand_range(0, 1))


func _on_Timer_timeout() -> void:
	if !has_moved:
		$Label.visible = true
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		has_moved = true


func _on_Area2D_tutorial_complete() -> void:
	mech.position = $Boulder.position
	mech.food = 100
	mech.speed = 0
	mech.XP = 0
	mech.XP_bar.max_value = 100
	mech.level = 0
	mech.bullet_speed = 0
	mech.bullet_damage = 0
	mech.bullet_reload = 0
	mech.max_health = 0
	mech.hunger_endurance = 0
	mech.chisel_speed = 0
	mech.stat_coins = 0
