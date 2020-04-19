extends Node2D
class_name Tower

signal fire(position, moves, direction)

var sprite : Sprite
var towerDef : TowerDef


func _ready():
	connect("fire", get_parent(), "_on_fire")
	
func set_Tower(value : TowerDef) -> void:
	sprite = $Sprite
	towerDef = value
	sprite.texture = value.texture

func _on_FireTimer_timeout():
	for pos in towerDef.fireDirections:
		emit_signal("fire", position + (pos * 16), towerDef.recursively_fire, pos)
