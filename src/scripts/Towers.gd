extends YSort
class_name Towers

var unit_prefab = load("res://prefabs/Unit.tscn")

var nav : Navigation2D
var tileMap : TileMap

func _ready():
	nav = get_parent().get_node("Navigation2D")
	tileMap = nav.get_node("TileMap")

func create(name : String, spawnPos : Vector2) -> void:
	var unit_def : UnitDef = load("res://resources/towers/"+name+".tres")
	var unit : Unit = unit_prefab.instance()
	add_child(unit)
	unit.set_Unit(unit_def)
	unit.position = spawnPos

func can_place(pos : Vector2) -> bool:
	return true

func get_king() -> Node2D:
	return get_node("King") as Node2D
