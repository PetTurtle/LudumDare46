extends Node2D
class_name TileGhost

onready var ghost : Sprite = $Sprite
onready var coin_label : Label = $Sprite/CostPanel/CostLabel
onready var cost_panel : Node2D = $Sprite/CostPanel

export(Texture) var x_texture

var gameMap : GameMap

func set_map(map : GameMap):
	gameMap = map

func set_cost(cost : int):
	coin_label.text = String(cost)
	cost_panel.show()

func show_ghost(texture : Texture = x_texture):
	ghost.texture = texture
	visible = true

func hide_ghost():
	visible = false
	cost_panel.hide()
