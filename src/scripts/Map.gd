extends Node2D
class_name GameMap

onready var navigator : Navigator = $Navigator
onready var unit_manager : UnitManager = $UnitManager
onready var king : Node2D = $King

func _ready():
	unit_manager.connect("set_path", self, "_on_set_path")

func build_turret():
	var pos = navigator.get_mouse_tile_position()
	navigator.build(pos.x, pos.y)
	unit_manager.update_paths()
	
func clear_turret():
	var pos = navigator.get_mouse_tile_position()
	navigator.clear_build(pos.x, pos.y)
	unit_manager.update_paths()

func can_build_turret() -> bool:
	var pos = navigator.get_mouse_tile_position()
	return navigator.can_build(pos.x, pos.y) and !navigator.can_block_path(pos.x, pos.y, unit_manager.get_spawners(), king.position)
	
func has_tile() -> bool:
	var pos = navigator.get_mouse_tile_position()
	return navigator.has_tile(pos.x, pos.y)
	
func has_turret() -> bool:
	var pos = navigator.get_mouse_tile_position()
	return navigator.has_build(pos.x, pos.y)
	
func get_snapped_mouse_position() -> Vector2:
	return navigator.get_snapped_tile_position()

func _on_set_path(unit : Unit):
	unit.path = navigator.get_simple_path(unit.position, king.position, false)
