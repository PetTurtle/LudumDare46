extends YSort
class_name Towers

var tower_prefab = load("res://prefabs/Tower.tscn")

var towers = []
var offset = Vector2(8, 8)

func _ready():
	pass

func create(name : String, spawnPos : Vector2) -> void:
	var tower_def : TowerDef = load("res://resources/towers/"+name+".tres")
	var tower : Tower = tower_prefab.instance()
	add_child(tower)
	tower.set_Tower(tower_def)
	tower.position = spawnPos + Vector2(8, 8)

func remove_at(pos : Vector2):
	for tower in get_children():
		if tower.position == pos + offset:
			tower.queue_free()
			return

func get_king() -> Node2D:
	return get_node("King") as Node2D
