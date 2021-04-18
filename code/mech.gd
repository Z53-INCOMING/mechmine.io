extends KinematicBody2D
class_name Mech

onready var health_loss_particle = $"UI/health loss particle"
onready var regen_timer = $"regen timer"
onready var art = $color
onready var food_bar = $UI/food
onready var health_bar = $UI/health
onready var UI = $UI
onready var XP_bar = $UI/XP
onready var XP_label = $UI/XPLabel
onready var max_health_bar = $"UI/max health"
onready var bullet_speed_bar = $"UI/bullet speed"
onready var bullet_damage_bar = $"UI/bullet damage"
onready var bullet_reload_bar = $"UI/bullet reload"
onready var hunger_endurance_bar = $"UI/hunger endurance"
onready var chisel_speed_bar = $"UI/chisel speed"
onready var speed_bar = $"UI/speed"
onready var stat_coin_label = $"UI/stat coin label"
onready var back_miner_evolution = $"UI/back miner evolution"
onready var twin_miner_evolution = $"UI/twin miner evolution"
onready var chisel1 = $color/Chisel
onready var chisel2 = $color/Chisel2
onready var chisel3 = $color/Chisel3
onready var chisel4 = $color/Chisel4
onready var spread_cannon1 = $"color/spread cannon"
onready var spread_cannon2 = $"color/spread cannon2"
onready var thruster = $color/thruster
onready var auto_turret1 = $"color/auto turret"
onready var auto_turret2 = $"color/auto turret2"
onready var cannon1 = $color/cannon
onready var cannon2 = $color/cannon2
onready var sniper_back_evolution = $"UI/sniper back evolution"
onready var auto_miner_evolution = $"UI/auto miner evolution"
onready var gunner_back_evolution = $"UI/gunner back evolution"
onready var quadro_dig_evolution = $"UI/quadro dig evolution"
onready var teamwork_evolution = $"UI/teamwork evolution"
onready var twin_sniper_evolution = $"UI/twin sniper evolution"
onready var rocketship_evolution = $"UI/rocketship evolution"
onready var excavator_evolution = $"UI/excavator evolution"
onready var skin = $color/circle

var team = ""
var mech_type = "miner"

var bullet_speed = 0
var bullet_damage = 0
var bullet_reload = 0
var speed = 0
var max_health = 0
var hunger_endurance = 0
var chisel_speed = 0

var health = 100
var food = 100
var XP = 0
var level = 0
var stat_coins = 0
var past_health

var auto_fire = false
var auto_mine = false
var velocity = Vector2.ZERO
var flipped = false

var skin_default = preload("res://skins/tank.png")
var skin_cloudy = preload("res://skins/cloudy tank skin.png")
var skin_cracked = preload("res://skins/cracked tank skin.png")
var skin_strike = preload("res://skins/strike tank skin.png")
var skin_angry_dude = preload("res://skins/angry dude skin.png")
var skin_zebra = preload("res://skins/zebra skin.png")
var skin_pizza = preload("res://skins/pizza skin.png")
var skin_missile = preload("res://skins/missile skin.png")
var skin_Z53_fan = preload("res://skins/Z53 fan skin.png")
var skin_team_support = preload("res://skins/team support skin.png")
var skin_sorry_not_sorry = preload("res://skins/sorry not sorry skin.png")

export var hunger_speed = 1

signal die

func evaluate_color():
	if team == "green":
		art.modulate = Color(0.04, 0.4, 0.11)
	if team == "blue":
		art.modulate = Color(0.04, 0.0, 0.53)
	if team == "purple":
		art.modulate = Color(0.62, 0.0, 1.0)
	if team == "black":
		art.modulate = Color(0.2, 0.2, 0.2)

func _ready() -> void:
#	skin.texture = skin_pizza
	chisel1.position = Vector2(7.8, -18.4)
	chisel1.rotation = 0
	chisel1.visible = true
	chisel1.scale = Vector2(2, 2)
	randomize()
	match round(rand_range(-0.5, 3.5)):
		0.0:
			team = "green"
		1.0:
			team = "blue"
		2.0:
			team = "purple"
		3.0:
			team = "black"
	evaluate_color()

func _process(delta: float) -> void:
	past_health = health
	if Input.is_action_pressed("ui_accept"):
		XP += 20
	max_health_bar.value = max_health
	bullet_speed_bar.value = bullet_speed
	bullet_damage_bar.value = bullet_damage
	bullet_reload_bar.value = bullet_reload
	hunger_endurance_bar.value = hunger_endurance
	chisel_speed_bar.value = chisel_speed
	speed_bar.value = speed
	
	if Input.is_action_just_pressed("auto fire"):
		auto_fire = !auto_fire
		if !auto_fire:
			thruster.stop_thrust()
	if Input.is_action_just_pressed("auto mine"):
		auto_mine = !auto_mine
	if Input.is_action_just_pressed("flip"):
		flipped = !flipped
	health_bar.value = health
	food_bar.value = food
	XP_bar.value = XP
	XP_label.text = str(level)
	var checky = true
	var checkx = true
	if Input.is_action_pressed("left"):
		velocity.x -= speed * 10 + 60
		
		checkx = false
	if Input.is_action_pressed("right"):
		velocity.x += speed * 10 + 60
		
		checkx = false
	if Input.is_action_pressed("up"):
		velocity.y -= speed * 10 + 60
		
		checky = false
	if Input.is_action_pressed("down"):
		velocity.y += speed * 10 + 60
		
		checky = false
	
	if checkx:
		velocity.x *= 0.9
	if checky:
		velocity.y *= 0.9
	rotation = Vector2(get_global_mouse_position() - global_position).angle()
	if flipped:
		rotation_degrees = rotation_degrees - 180
	skin.rotation = 0 - rotation
	
	stat_coin_label.text = str(stat_coins)
	
	if Input.is_action_pressed("mine") or auto_mine:
		for chisel in get_tree().get_nodes_in_group("Chisels"):
			if chisel.visible:
				chisel.chisel_speed = chisel_speed
				chisel.break_block()
	if Input.is_action_pressed("shoot") or auto_fire:
		if thruster.visible:
			velocity += thruster.thrust()
		for gun in get_tree().get_nodes_in_group("guns"):
			if gun.visible:
				gun.bullet_reload = bullet_reload
				gun.bullet_damage = bullet_damage
				gun.bullet_speed = bullet_speed
				gun.modulate = art.modulate
				gun.shoot()
				gun.modulate = Color(1.0, 1.0, 1.0)
	if Input.is_action_just_released("shoot"):
		thruster.stop_thrust()
	if health <= 0:
		emit_signal("die")
		queue_free()
	var mobility = 100 + (speed * 12)
	if checkx and checky:
		if abs(velocity.x) > 600:
			velocity.x = sign(velocity.x) * 600
		if 600 < abs(velocity.y):
			velocity.y = sign(velocity.y) * 600
	else:
		if abs(velocity.x) > mobility:
			velocity.x = sign(velocity.x) * mobility
		if mobility < abs(velocity.y):
			velocity.y = sign(velocity.y) * mobility
	velocity = move_and_slide(velocity, Vector2.UP, true, 4, 0, false)
	health_bar.max_value = (max_health * 10) + 100
	food_bar.max_value = (hunger_endurance * 10) + 100
	if food > food_bar.max_value:
		food = food_bar.max_value
	if XP >= XP_bar.max_value and XP_label.text != str(30):
		XP = XP - XP_bar.max_value
		
		XP_bar.max_value *= 1.1
		XP_bar.max_value = round(XP_bar.max_value)
		level += 1
		stat_coins += 1
		$UI/Xp_particle.emitting = true
		
		if level == 10:
			twin_miner_evolution.visible = true
			back_miner_evolution.visible = true
		if level == 20:
			if mech_type == "back miner":
				sniper_back_evolution.visible = true
				gunner_back_evolution.visible = true
				auto_miner_evolution.visible = true
			else:
				teamwork_evolution.visible = true
				quadro_dig_evolution.visible = true
				auto_miner_evolution.visible = true
		if level == 30:
			if mech_type == "sniper back":
				rocketship_evolution.visible = true
				twin_sniper_evolution.visible = true
			if mech_type == "quadro dig":
				excavator_evolution.visible = true
			XP_label.visible = false
			XP_bar.visible = false
			

func _on_Timer_timeout() -> void:
	food -= hunger_speed
func _on_Chisel_stone() -> void:
	XP += 1
func _on_Chisel_iron() -> void:
	XP += 25
func _on_Chisel_coal() -> void:
	XP += 10
func _on_Chisel_daimond() -> void:
	XP += 50
func _on_health_timer_timeout() -> void:
	if food <= 0:
		health -= 1
		health_loss_particle.emitting = true
	else:
		health_loss_particle.emitting = false
func _on_chisel_speed_button_button_down() -> void:
	if stat_coins > 0 and chisel_speed != 10:
		chisel_speed += 1
		stat_coins -= 1
func _on_hunger_endurance_button_button_down() -> void:
	if stat_coins > 0 and hunger_endurance != 10:
		hunger_endurance += 1
		stat_coins -= 1
		food += 10
func _on_bullet_reload_button_button_down() -> void:
	if stat_coins > 0 and bullet_reload != 10:
		bullet_reload += 1
		stat_coins -= 1
func _on_bullet_damage_button_button_down() -> void:
	if stat_coins > 0 and bullet_damage != 10:
		bullet_damage += 1
		stat_coins -= 1
func _on_bullet_speed_button_button_down() -> void:
	if stat_coins > 0 and bullet_speed != 10:
		bullet_speed += 1
		stat_coins -= 1
func _on_speed_button_button_down() -> void:
	if stat_coins > 0 and speed != 10:
		speed += 1
		stat_coins -= 1
func _on_max_health_button_button_down() -> void:
	if stat_coins > 0 and max_health != 10:
		max_health += 1
		stat_coins -= 1
		health += 10
func _on_twin_miner_evolution_button_down() -> void:
	twin_miner_evolution.visible = false
	back_miner_evolution.visible = false
	chisel1.position = Vector2(13, -15)
	chisel2.position = Vector2(12.7, 12.3)
	chisel2.visible = true
	chisel2.rotation_degrees = 0
	mech_type = "twin miner"
func _on_back_miner_evolution_button_down() -> void:
	twin_miner_evolution.visible = false
	back_miner_evolution.visible = false
	chisel1.position = Vector2(-19, 0)
	chisel1.rotation_degrees = 176.5
	cannon1.visible = true
	cannon1.position = Vector2(22.3, -0.4)
	cannon1.scale.x = 1.3
	mech_type = "back miner"
func _on_sniper_back_evolution_button_down() -> void:
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	cannon1.position = Vector2(22.3, -0.4)
	cannon1.rotation_degrees = 0
	cannon1.scale = Vector2(2.3, 1.3)
	cannon1.speed = 1.3
	cannon1.reload = 0.8
	cannon1.damage = 1.6
	mech_type = "sniper back"
func _on_gunner_back_evolution_button_down() -> void:
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	spread_cannon1.position = Vector2(24, -0.6)
	spread_cannon1.reload = 1.4
	spread_cannon1.visible = true
	spread_cannon1.rotation_degrees = 0
	spread_cannon1.damage = 0.8
	mech_type = "gunner back"
	cannon1.visible = false
func _on_auto_miner_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	chisel1.position = Vector2(22.7, 0.4)
	chisel1.rotation_degrees = 0
	auto_turret1.visible = true
	auto_turret1.position = Vector2(-1.4, 27.5)
	auto_turret1.rotation_degrees = 91
	auto_turret1.scale = Vector2(1.4, 1.4)
	mech_type = "auto miner"
	cannon1.visible = false
	chisel2.visible = false
func _on_quadro_dig_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	auto_miner_evolution.visible = false
	chisel3.visible = true
	chisel4.visible = true
	cannon1.visible = true
	cannon1.scale = Vector2(1.3, 1.3)
	cannon1.rotation_degrees = 0
	cannon1.position = Vector2(23.7, -0.4)
	cannon1.reload = 1
	cannon1.speed = 1
	chisel2.position = Vector2(-15.7, -18.7)
	chisel2.rotation_degrees = -135
	chisel3.position = Vector2(-18.7, 15.8)
	chisel3.rotation_degrees = 135
	chisel4.position = Vector2(16.8, -17.9)
	chisel4.rotation_degrees = -45
	chisel1.position = Vector2(17.1, 16.4)
	chisel1.rotation_degrees = 45
	mech_type = "quadro dig"
func _on_teamwork_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	auto_miner_evolution.visible = false
	chisel2.visible = false
	cannon1.visible = true
	cannon1.position = Vector2(12.7, 14.2)
	cannon1.scale = Vector2(2, 1.3)
	cannon1.reload = 1
	cannon1.speed = 1
	mech_type = "teamwork"
func _on_rocketship_evolution_button_down() -> void:
	twin_sniper_evolution.visible = false
	rocketship_evolution.visible = false
	cannon1.visible = true
	cannon1.position = Vector2(16.4, -0.5)
	cannon1.rotation = 0
	cannon1.scale = Vector2(3, 1.3)
	cannon1.speed = 1.4
	cannon1.reload = 0.8
	chisel1.visible = true
	chisel1.position = Vector2(-0.2, -0.7)
	chisel1.rotation_degrees = -90
	chisel2.visible = true
	chisel2.position = Vector2(-0.1, 0.6)
	chisel2.rotation_degrees = 90
	thruster.force = 15
	thruster.visible = true
	mech_type = "rocketship"
func _on_twin_sniper_evolution_button_down() -> void:
	twin_sniper_evolution.visible = false
	rocketship_evolution.visible = false
	chisel1.position = Vector2(-19.5, 1.3)
	chisel1.rotation_degrees = 180
	chisel1.visible = true
	chisel2.visible = false
	cannon2.position = Vector2(15.7, 12.7)
	cannon2.rotation_degrees = 0
	cannon2.speed = 1.4
	cannon2.reload = 0.9
	cannon2.scale = Vector2(2, 1.3)
	cannon1.position = Vector2(16.1, -11.7)
	cannon1.scale = Vector2(2, 1.3)
	cannon1.speed = 1.4
	cannon1.reload = 0.9
	cannon1.visible = true
	cannon2.visible = true
	cannon1.damage = 1.3
	cannon2.damage = 1.3
	
	mech_type = "twin sniper"
func _on_excavator_evolution_button_down() -> void:
	excavator_evolution.visible = false
	chisel3.visible = false
	chisel4.visible = false
	chisel2.visible = false
	chisel1.position = Vector2(-13, 0)
	chisel1.rotation_degrees = 0
	chisel1.scale = Vector2(5, 5)
	spread_cannon1.visible = true
	spread_cannon1.position = Vector2(0.2, -27.5)
	spread_cannon1.rotation_degrees = -90
	spread_cannon1.scale = Vector2(1, 2)
	spread_cannon2.visible = true
	spread_cannon2.rotation_degrees = 90
	spread_cannon2.scale = Vector2(1, 2)
	spread_cannon2.position = Vector2(-0.8, 25.9)
	spread_cannon1.spread = 45
	spread_cannon2.spread = 45
	cannon1.visible = false
	thruster.visible = true
	mech_type = "Excavator"
