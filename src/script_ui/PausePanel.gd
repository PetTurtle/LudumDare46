extends Panel


var game_manager : GameManager

func _ready():
	game_manager = get_node("/root/GameManager")
	game_manager.connect("pause", self, "_on_pause")
	game_manager.connect("unpause", self, "_on_unpause")

func _on_pause():
	visible = true
	
func _on_unpause():
	visible = false
