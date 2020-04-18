extends Node2D

onready var pathFinder : PathFinder = $Navigation2D
onready var units : Units = $Units

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return

	if event.button_index == BUTTON_LEFT:
		pathFinder.block_cell(get_global_mouse_position(), -1)
	elif event.button_index == BUTTON_RIGHT:
		pathFinder.unBlock_cell(get_global_mouse_position(), 0)
		
