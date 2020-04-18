extends Node2D
class_name UnitManager

signal set_path(unit)

onready var ySort : YSort = $Units

var spawners = []
var unit_prefab = load("res://prefabs/Unit.tscn")

func _ready():
	for node in get_children():
		if node is Spawner:
			spawners.append(node)
			node.connect("spawn", self, "_on_spawn")
	
func update_paths():
	for unit in ySort.get_children():
		emit_signal("set_path", unit)

func get_spawners():
	return spawners

func _on_spawn(unit_name : String, positon : Vector2):
	var unit_def : UnitDef = load("res://resources/units/"+unit_name+".tres")
	var unit : Unit = unit_prefab.instance()
	ySort.add_child(unit)
	unit.set_Unit(unit_def)
	unit.position = positon
	emit_signal("set_path", unit)

