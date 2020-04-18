extends YSort
class_name Units

var unit_prefab = load("res://prefabs/Unit.tscn")
var nav : PathFinder
var kingPos : Vector2

func _ready():
	nav = get_parent().get_node("PathFinder")
	kingPos = get_parent().get_node("Towers").get_king().position

func create(name : String, spawnPos : Vector2) -> void:
	var unit_def : UnitDef = load("res://resources/units/"+name+".tres")
	var unit : Unit = unit_prefab.instance()
	add_child(unit)
	unit.set_Unit(unit_def)
	unit.position = spawnPos
	unit.path = nav.get_simple_path(spawnPos, kingPos, false)
	
func update_paths():
	var children = get_children()
	for i in range(children.size()):
		children[i].path = nav.get_simple_path(children[i].position, kingPos, false)

func can_reach_king(pos : Vector2) -> bool:
	return nav.get_simple_path(pos, kingPos, false).size() > 0
