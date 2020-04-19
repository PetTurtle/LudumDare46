extends Area2D
class_name Bullet

onready var next_tile_timer : Timer = $NextTileTimer
onready var animation : AnimationPlayer = $AnimationPlayer

var moves : bool
var dir : Vector2
var map : GameMap

func _ready():
	next_tile_timer.connect("timeout", self, "_on_timeout")
	connect("area_entered", self, "collision")
	animation.play("Modulate")

func set_bullet(pos : Vector2, _moves : bool, direction : Vector2, game_map : GameMap):
	position = pos
	moves = _moves
	dir = direction * 16
	map = game_map
	
	
func collision(area):
	if area is Unit:
		area.damage(1)
	
func _on_timeout():
	if moves:
		var newPos = position + dir
		if map.is_pathable(newPos):
			position = newPos
			animation.play("Modulate")
		else:
			queue_free()
	else:
		queue_free()
