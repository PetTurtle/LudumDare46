extends Node2D
class_name AttackCells

export var texture: Texture = preload("res://assets/FireZone.png")
export(Resource) var tower_def = preload("res://resources/towers/Pawn.tres")

var gameMap : GameMap
var _bullet_scene: PackedScene = preload("res://prefabs/GhostBullet.tscn")

func draw_cells():
	for direction in tower_def.fireDirections:
		var bullet := _bullet_scene.instance()
		add_child(bullet)
		bullet.move_direction = direction
		bullet.position = Vector2(0, 11) + (direction * 16)
		bullet.can_move = tower_def.recursively_fire


func clear_cells():
	for child in get_children():
		remove_child(child)


func update():
	clear_cells()
	draw_cells()
