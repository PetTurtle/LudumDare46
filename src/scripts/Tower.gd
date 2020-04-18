extends Node2D
class_name Tower

var sprite : Sprite
var towerDef : TowerDef

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func set_Tower(value : TowerDef) -> void:
	sprite = $Sprite
	towerDef = value
	sprite.texture = value.texture

func _on_FireTimer_timeout():
	pass # Replace with function body.
