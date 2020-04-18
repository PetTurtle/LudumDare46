extends Node2D
class_name Bullet

onready var next_tile_timer : Timer
export(Curve) var curve : Curve

var moves : bool
var dir : Vector2

func _process(delta : float) -> void:
	pass

func set_bullet(pos : Vector2, _moves : bool, direction : Vector2):
	position = pos
	moves = _moves
	dir = direction * 16
	if moves:
		next_tile_timer = $NextTileTimer
		next_tile_timer.start()
		next_tile_timer.connect("timeout", self, "_on_timeout")
	
func _on_timeout():
	position = position + dir
