extends Panel

onready var menu_button : Button = $Panel/VBoxContainer/MenuButton
var game_manager : GameManager

func _ready():
	game_manager = get_node("/root/GameManager")
	game_manager.connect("pause", self, "_on_pause")
	game_manager.connect("unpause", self, "_on_unpause")
	menu_button.connect("pressed", self, "gameover")
	

func gameover():
	unpause()
	game_manager.main_menu()

func unpause():
	game_manager.toggle_pause()

func _on_pause():
	visible = true
	
func _on_unpause():
	visible = false
