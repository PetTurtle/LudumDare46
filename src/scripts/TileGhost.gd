extends Node2D
class_name TileGhost

onready var ghost : Sprite = $Sprite

export(Texture) var x_texture

var gameMap : GameMap
var offset = Vector2(8, -3)

func _ready():
	pass
	
func set_map(map : GameMap):
	gameMap = map

func show_ghost(pos : Vector2, texture : Texture = x_texture):
	var new_pos = pos + offset
	ghost.visible = true
	ghost.position = new_pos
	ghost.texture = texture
	
func hide_ghost():
	ghost.visible = false
