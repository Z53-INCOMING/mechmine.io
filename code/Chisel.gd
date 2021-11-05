extends Node2D

signal iron
signal coal
signal stone
signal daimond

onready var timer = $Timer
onready var raycastT = $RayCast2DT
onready var raycastM = $RayCast2DM
onready var raycastB = $RayCast2DB
onready var raycastT2 = $RayCast2DT2
onready var raycastT3 = $RayCast2DT3
onready var raycastM2 = $RayCast2DM2
onready var raycastM3 = $RayCast2DM3
onready var raycastB2 = $RayCast2DB2
onready var raycastB3 = $RayCast2DB3

onready var animation = $AnimationPlayer
var break_scene = preload("res://scenes/break effect.tscn")

var chisel_speed = 0
func break_block():
	timer.wait_time = (1.1 - (chisel_speed * 0.1)) / 2
	if timer.time_left <= 0:
		animation.play("chisel")
		raycast(raycastT)
		raycast(raycastB)
		raycast(raycastM)
		raycast(raycastT2)
		raycast(raycastM2)
		raycast(raycastB2)
		raycast(raycastT3)
		raycast(raycastM3)
		raycast(raycastB3)
		timer.start()
func raycast(raycast_node):
	if raycast_node.is_colliding():
		var tileMapT := raycast_node.get_collider() as TileMap
		
		var pointT = raycast_node.get_collision_point()
		var tileCoordT := tileMapT.world_to_map(pointT)
		var cellCoord := tileMapT.get_cell_autotile_coord(tileCoordT.x, tileCoordT.y)
		match cellCoord.x:
			2.0: 
				emit_signal("stone")
			3.0:
				emit_signal("iron")
			4.0:
				emit_signal("daimond")
			1.0:
				emit_signal("coal")
			0.0:
				return
		tileMapT.set_cellv(tileCoordT, -1)
		var breakf = break_scene.instance()
		var main = get_tree().current_scene
		breakf.global_position = pointT
		breakf.rotation = rotation
		main.add_child(breakf)
