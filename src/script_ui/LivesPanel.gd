extends PanelContainer

onready var animation : AnimatedSprite = $AnimatedSprite
onready var label : Label = $Label

var game_manager : GameManager
func _ready():
	game_manager = get_node("/root/GameManager")
	game_manager.connect("king_damaged", self, "update_lives")

func update_lives(amount : int):
	label.text = String(amount)
