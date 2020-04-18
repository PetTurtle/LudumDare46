extends Navigation2D
class_name PathFinder

export(Vector2) var topRight
export(Vector2) var bottomLeft

onready var tileMap : TileMap = $TileMap
var spawners : Array
var units

func _ready():
	units = get_parent().get_node("Units")
	spawners = get_parent().get_node("Spawners").get_children()

func block_cell(pos : Vector2, id : int = 1) -> void:
	var tile_pos : Vector2 = tileMap.world_to_map(pos)
	if _can_reach_king(tile_pos.x, tile_pos.y):
		set_cell(tile_pos, id)
	else:
		print("Failed To Place Tower")
		
func unBlock_cell(pos : Vector2, id : int = -1) -> void:
	var tile_pos : Vector2 = tileMap.world_to_map(pos)
	set_cell(tile_pos, id)

func can_place_tower(pos : Vector2) -> bool:
	var tile_pos : Vector2 = tileMap.world_to_map(pos)
	return _can_reach_king(tile_pos.x, tile_pos.y)

func set_cell(pos : Vector2, id : int) -> void:
	tileMap.set_cell(pos.x, pos.y, id)
	tileMap.update_dirty_quadrants()
	units.update_paths()

func _can_reach_king(x : int, y : int) -> bool:
	var cellId = tileMap.get_cell(x, y)
	tileMap.set_cell(x, y, -1)
	tileMap.update_dirty_quadrants()
	for i in range(spawners.size()):
		if !_spawner_can_reach(i):
			tileMap.set_cell(x, y, cellId)
			tileMap.update_dirty_quadrants()
			return false
			
	tileMap.set_cell(x, y, cellId)
	tileMap.update_dirty_quadrants()
	return true
	
func _spawner_can_reach(id : int) -> bool:
	return units.can_reach_king(spawners[id].position)
