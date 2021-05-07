extends Mech
class_name PlayerMech

onready var health_loss_particle = $"UI/health loss particle"
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
onready var sniper_back_evolution = $"UI/sniper back evolution"
onready var auto_miner_evolution = $"UI/auto miner evolution"
onready var gunner_back_evolution = $"UI/gunner back evolution"
onready var quadro_dig_evolution = $"UI/quadro dig evolution"
onready var teamwork_evolution = $"UI/teamwork evolution"
onready var twin_sniper_evolution = $"UI/twin sniper evolution"
onready var rocketship_evolution = $"UI/rocketship evolution"
onready var excavator_evolution = $"UI/excavator evolution"
onready var skins = $"UI/menu items/skins"

func _process(delta: float) -> void:
	skin.texture = skins.skin
	max_health_bar.value = max_health
	bullet_speed_bar.value = bullet_speed
	bullet_damage_bar.value = bullet_damage
	bullet_reload_bar.value = bullet_reload
	hunger_endurance_bar.value = hunger_endurance
	chisel_speed_bar.value = chisel_speed
	speed_bar.value = speed
	health_bar.value = health
	food_bar.value = food
	XP_bar.value = XP
	XP_label.text = str(level)
	stat_coin_label.text = str(stat_coins)
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

func _on_health_timer_timeout() -> void:
	._on_health_timer_timeout()
	if food <= 0:
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
	evolve_twin_miner()
func _on_back_miner_evolution_button_down() -> void:
	twin_miner_evolution.visible = false
	back_miner_evolution.visible = false
	evolve_back_miner()
func _on_sniper_back_evolution_button_down() -> void:
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	evolve_sniper_back()
func _on_gunner_back_evolution_button_down() -> void:
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	evolve_gunner_back()
func _on_auto_miner_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	sniper_back_evolution.visible = false
	gunner_back_evolution.visible = false
	auto_miner_evolution.visible = false
	evolve_auto_miner()
func _on_quadro_dig_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	auto_miner_evolution.visible = false
	evolve_quadro_dig()
func _on_teamwork_evolution_button_down() -> void:
	quadro_dig_evolution.visible = false
	teamwork_evolution.visible = false
	auto_miner_evolution.visible = false
	evolve_teamwork()
func _on_rocketship_evolution_button_down() -> void:
	twin_sniper_evolution.visible = false
	rocketship_evolution.visible = false
	evolve_rocketship()
func _on_twin_sniper_evolution_button_down() -> void:
	twin_sniper_evolution.visible = false
	rocketship_evolution.visible = false
	evolve_twin_sniper()
func _on_excavator_evolution_button_down() -> void:
	excavator_evolution.visible = false
	evolve_excavator()
