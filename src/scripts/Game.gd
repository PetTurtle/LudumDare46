extends Node2D

onready var ui : UI = $UI
onready var map : GameMap = $Map1 # TODO LEVEL Loading System

func _ready():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return

	if event.button_index == BUTTON_LEFT:
		if map.can_build_turret():
			map.build_turret()
	elif event.button_index == BUTTON_RIGHT:
		if map.has_turret():
			map.clear_turret()
