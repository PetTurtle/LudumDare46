extends Node2D
class_name WaveController

onready var timer : Timer = $Timer

signal spawn(unit_name, pos)

var waveCount : int = 0
var iterator : int = 0
var max_value : int = 100
var value_left : int = 0
var spawnPoints = []

var game_data : GameData
var game_manager : GameManager

func _ready():
	game_data = get_node("/root/GameData")
	game_manager = get_node("/root/GameManager")
	timer.connect("timeout", self, "_on_spawn")
	for node in get_children():
		if node is Node2D:
			spawnPoints.append(node)

func next_wave():
	waveCount += 1
	game_data.set_wave_count(waveCount)
	value_left = int(get_wave_value(waveCount))
	timer.paused = false
	
func get_wave_value(index) -> float:
	return 12*index*index
	
func get_spawn_points() -> Array:
	return spawnPoints
	
func is_wave_over():
	return timer.paused
	
func _on_spawn():
	if value_left > 0:
		iterator = (iterator + 1) % spawnPoints.size()
		var value : int = int(rand_range(1, min(waveCount, max_value)))
		if value > value_left:
			value = value_left
		value_left -= value
		emit_signal("spawn", value, spawnPoints[iterator].position)
	else:
		timer.paused = true
		game_manager.wave_over()
