extends Node2D
class_name GhostBullet

var move_direction : Vector2
var can_move : bool = false setget set_can_move

var _initial_position : Vector2

func set_can_move(moves):
	can_move = moves
	if can_move:
		_initial_position = position
		$MoveTimer.start()
		$ResetTimer.start()

func move():
	var desired_position := position + 16 * move_direction
	position = desired_position


func _on_ResetTimer_timeout() -> void:
	position = _initial_position
	show()
	$MoveTimer.start()

func _on_MoveTimer_timeout() -> void:
	move()
