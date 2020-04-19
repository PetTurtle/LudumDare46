extends Panel

onready var wave_label : Label = $VBoxContainer/WaveLabel

var game_data : GameData
var game_manager : GameManager
func _ready():
	game_data = get_node("/root/GameData")
	game_manager = get_node("/root/GameManager")

func show_panel(value : bool):
	visible = value
	if visible:
		wave_label.text = "Wave: " + String(game_data.get_wave_count())

func _on_continue():
	game_manager.main_menu()
