extends Navigation2D
class_name Navigator

enum TypeType {
	Move,
	Turret,
	UnBuildable
}

onready var tileMap : TileMap = $TileMap
var build_tile_id
var move_tile_id

func _ready():
	build_tile_id = tileMap.tile_set.find_tile_by_name("Turret")
	move_tile_id = tileMap.tile_set.find_tile_by_name("Move")

func build(x : int, y : int):
	tileMap.set_cell(x, y, build_tile_id)
	tileMap.update_dirty_quadrants()
	
func clear_build(x : int, y : int):
	tileMap.set_cell(x, y, move_tile_id)
	tileMap.update_dirty_quadrants()
	
func can_build(x : int, y : int) -> bool:
	return get_tile_type(x, y) == TypeType.Move
	
func can_block_path(x : int, y : int, spawners, end : Vector2) -> bool:
	var cellId = tileMap.get_cell(x, y)
	tileMap.set_cell(x, y, -1)
	tileMap.update_dirty_quadrants()
	for spawner in spawners:
		if get_simple_path(spawner.position, end, false).size() == 0:
			tileMap.set_cell(x, y, cellId)
			tileMap.update_dirty_quadrants()
			return true
	tileMap.set_cell(x, y, cellId)
	tileMap.update_dirty_quadrants()
	return false
	
func has_tile(x : int, y : int) -> bool:
	var tile_type = get_tile_type(x, y)
	return tile_type == TypeType.Move || tile_type == TypeType.Turret || tile_type == TypeType.UnBuildable
	
func has_build(x : int, y : int) -> bool:
	return get_tile_type(x, y) == TypeType.Turret
	
func get_mouse_tile_position() -> Vector2:
	return tileMap.world_to_map(get_global_mouse_position())
	
func get_snapped_tile_position() -> Vector2:
	return tileMap.map_to_world(get_mouse_tile_position())

func get_pos_tile_position(pos : Vector2) -> Vector2:
	return tileMap.world_to_map(pos)

func get_tile_type(x : int, y : int) -> int:
	var tile_id = tileMap.get_cell(x, y)
	var tile_type = -1
	if tile_id >= 0:
		var tile_name = tileMap.tile_set.tile_get_name(tile_id)
		match tile_name:
			"Move":
				tile_type = TypeType.Move
			"Turret":
				tile_type = TypeType.Turret
			"UnBuildable":
				tile_type = TypeType.UnBuildable
	return tile_type
