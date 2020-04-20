extends Node2D
class_name TileGhost

onready var ghost : Sprite = $Sprite
onready var coin_label : Label = $Sprite/CostPanel/CostLabel

export(Texture) var x_texture

var gameMap : GameMap
var offset = Vector2(8, -3)

func _ready():
	pass
	
func set_map(map : GameMap):
	gameMap = map

func show_ghost(pos : Vector2, cost : int, texture : Texture = x_texture):
	var new_pos = pos + offset
	ghost.visible = true
	ghost.position = new_pos
	ghost.texture = texture
	coin_label.text = String(cost)
	
func hide_ghost():
	ghost.visible = false
