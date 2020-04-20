extends Area2D
class_name Unit

signal death(value)

var speed : float = 30

var health : int = 1
var sprite : Sprite = null
var path : = PoolVector2Array() setget set_path

func _ready() -> void:
	set_process(false)
	
func _process(delta: float) -> void:
	var move_distance = speed * delta
	_move_along_path(move_distance)

func set_Unit(value : int, texture : Texture) -> void:
	sprite = $Sprite
	health = value
	sprite.texture = texture
	sprite.scale.x = 0.5 + health * 0.015
	sprite.scale.y = 0.5 + health * 0.015

func _move_along_path(distance : float) -> void:
	var start_point = position
# warning-ignore:unused_variable
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0: 
			position = start_point.linear_interpolate(path[0], distance/distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		
func damage(amount : int):
	health = health - amount
	if health <= 0:
		queue_free()
	else:
		sprite.scale.x = 0.5 + health * 0.02
		sprite.scale.y = 0.5 + health * 0.02

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
func _exit_tree():
	emit_signal("death", 1)
