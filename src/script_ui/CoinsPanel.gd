extends Panel

onready var texture_Rect : TextureRect = $TextureRect
onready var label : Label = $Label

func update_coins(amount : int):
	label.text = String(amount)
