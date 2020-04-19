extends Node

signal tower_placed()
signal tower_removed()

var towers_to_key : Dictionary
var towers = []
var tower_count = []
var cost_multi = 0.1
var wave_count : int = 0

func _ready():
	_load_towers()
	
func get_tower_def(name : String) -> TowerDef:
	var key = towers_to_key[name]
	return towers[key]
	
func get_tower_cost(name : String) -> int:
	var key = towers_to_key[name]
	return towers[key].cost + (towers[key].cost * tower_count[key] * cost_multi)
	
func add_tower(name : String):
	var key = towers_to_key[name]
	tower_count[key] += 1
	emit_signal("tower_placed")
	
func remove_tower(name : String):
	var key = towers_to_key[name]
	tower_count[key] -= 1
	emit_signal("tower_removed")
	
func set_wave_count(value):
	wave_count = value
	
func get_wave_count() -> int:
	return wave_count
	
func clear_all():
	for i in range(tower_count.size()):
		tower_count[i] = 0

func _load_towers():
	var key = 0
	var dir = Directory.new()
	dir.open("res://resources/towers/")
	dir.list_dir_begin(true)
	var tower = dir.get_next()
	while tower != "":
		var def : TowerDef = load("res://resources/towers/"+tower)
		towers_to_key[def.name] = key
		towers.insert(key, def)
		tower_count.insert(key, 0)
		tower = dir.get_next()
		key += 1
