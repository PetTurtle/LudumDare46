extends Node2D
class_name Spawner

signal spawn(unit_name, pos)

onready var spawnTimer : Timer = $SpawnTimer

func _ready() -> void:
	spawnTimer.connect("timeout", self, "_on_SpawnTimer_timeout")

func _on_SpawnTimer_timeout():
	emit_signal("spawn", "Red", position)
