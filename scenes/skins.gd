extends Button

var count = 3

var skin_names = ["Angry", "Cloudy", "Cracked", "Mech", "Missile", "Pizza", "Sorry not sorry", "Striker", "Team Support", "Z53 Fan", "Zebra"]

var skin_textures = [preload("res://skins/angry dude skin.png"), preload("res://skins/cloudy tank skin.png"), preload("res://skins/cracked tank skin.png"), preload("res://skins/mech.png"), preload("res://skins/missile skin.png"), preload("res://skins/pizza skin.png"), preload("res://skins/sorry not sorry skin.png"), preload("res://skins/strike tank skin.png"), preload("res://skins/team support skin.png"), preload("res://skins/Z53 Fan skin.png"), preload("res://skins/zebra skin.png")]

var skin = preload("res://skins/mech.png")

func _on_skins_button_down() -> void:
	count += 1
	if count > skin_names.size() - 1:
		count = 0
	text = skin_names[count]
	icon = skin_textures[count]
	skin = icon
