extends PanelContainer

onready var animation : AnimatedSprite = $AnimatedSprite
onready var label : Label = $Label

var game_manager : GameManager
func _ready():
	game_manager = get_node("/root/GameManager")
	game_manager.connect("coin_update", self, "update_coins")

func update_coins(amount : int):
	label.text = String(amount)
