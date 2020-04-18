extends Node2D
class_name Spawner

onready var spawnTimer : Timer = $SpawnTimer

var units

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	units = get_parent().get_parent().get_node("Units")

func _on_SpawnTimer_timeout():
	for i in range(1):
		units.create("Red", position)
