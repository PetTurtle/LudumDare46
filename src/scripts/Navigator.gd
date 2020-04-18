extends Navigation2D
class_name Navigator

onready var tileMap : TileMap = $TileMap

func build(x : int, y : int):
	tileMap.set_cell(x, y, 1)
	tileMap.update_dirty_quadrants()
	
func clear_build(x : int, y : int):
	tileMap.set_cell(x, y, 0)
	tileMap.update_dirty_quadrants()
	
func can_build(x : int, y : int) -> bool:
	return tileMap.get_cell(x, y) == 0
	
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
	return tileMap.get_cell(x, y) != -1
	
func has_build(x : int, y : int) -> bool:
	return tileMap.get_cell(x, y) == 1
	
func get_mouse_tile_position() -> Vector2:
	return tileMap.world_to_map(get_global_mouse_position())
	
func get_snapped_tile_position() -> Vector2:
	return tileMap.map_to_world(get_mouse_tile_position())
