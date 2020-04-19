extends HBoxContainer

signal place_unit(name)
signal mode_sell()

func _ready():
	pass

func show_towers():
	pass

func hide_towers():
	pass
	
func _on_place_unit(unit_name):
	emit_signal("place_unit", unit_name)

func _on_ButtonSell_pressed():
	emit_signal("mode_sell")

func show_panel(value : bool):
	visible = value
