extends YSort
class_name Towers

var tower_prefab = load("res://prefabs/Tower.tscn")

var nav : PathFinder
var towers = []

func _ready():
	nav = get_parent().get_node("PathFinder")

func create(name : String, spawnPos : Vector2) -> void:
	var tower_def : UnitDef = load("res://resources/towers/"+name+".tres")
	var tower : Tower = tower_prefab.instance()
	add_child(tower)
	
	tower.position = spawnPos

func get_king() -> Node2D:
	return get_node("King") as Node2D
