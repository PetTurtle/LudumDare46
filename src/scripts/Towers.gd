extends Node2D
class_name Towers

signal fire(position, moves, direction)

onready var timer : Timer = $Timer
onready var ySort : YSort = $YSort

var tower_prefab = load("res://prefabs/Tower.tscn")
var offset = Vector2(8, 8)

func _ready():
	connect("fire", get_parent(), "_on_fire")
	timer.connect("timeout", self, "_on_timer")

func create(tower_def : TowerDef, spawnPos : Vector2) -> void:
	var tower : Tower = tower_prefab.instance()
	ySort.add_child(tower)
	tower.set_Tower(tower_def)
	tower.position = spawnPos + Vector2(8, 8)

func remove_at(pos : Vector2):
	for tower in ySort.get_children():
		if tower.position == pos + offset:
			tower.queue_free()
			return
			
func tower_def_at(pos : Vector2) -> TowerDef:
	for tower in ySort.get_children():
		if tower.position == pos + offset:
			return tower.get_def()
	return null

func get_king() -> Node2D:
	return get_node("King") as Node2D
	
func _on_timer() -> void:
	for tower in ySort.get_children():
		tower.fire()

func _on_fire(position, moves, direction):
	emit_signal("fire", position, moves, direction)
	
func clear_all():
	for node in ySort.get_children():
		node.queue_free()
