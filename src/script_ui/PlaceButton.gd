extends Button

signal place_unit(name)

export(String) var unit_name

func _pressed():
	emit_signal("place_unit", unit_name)
