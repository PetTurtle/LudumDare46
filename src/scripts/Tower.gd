extends Node2D
class_name Tower

signal fire(position, moves, direction)

var sprite : Sprite
var tower_def : TowerDef

func _ready():
	connect("fire", get_parent().get_parent(), "_on_fire")
	
func set_Tower(value : TowerDef) -> void:
	sprite = $Sprite
	tower_def = value
	sprite.texture = value.get_texture()

func get_def() -> TowerDef:
	return tower_def

func fire():
	for pos in tower_def.fireDirections:
		emit_signal("fire", position + (pos * 16), tower_def.recursively_fire, pos)
