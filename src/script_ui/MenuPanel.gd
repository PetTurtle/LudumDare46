extends Panel

onready var title_label : Label = $TitleLabel
onready var left_button : Button = $LevelPanel/HBox/LeftButton
onready var right_button : Button = $LevelPanel/HBox/RightButton
onready var play_button : Button = $LevelPanel/HBox/PlayButton
onready var level_label : Label = $LevelPanel/LevelLabel

var game_manager : GameManager
func _ready():
	game_manager = get_node("/root/GameManager")

func play():
	game_manager.new_game()
	
func next_level():
	game_manager.next_map()
	level_label.text = String(game_manager.get_map_index())
	
func prev_level():
	game_manager.prev_map()
	level_label.text = String(game_manager.get_map_index())

func show_panel(value : bool):
	visible = value
