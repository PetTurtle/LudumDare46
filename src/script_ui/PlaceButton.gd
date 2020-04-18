extends Button

signal place_unit(name)

export(String) var unit_name

func _ready():
	connect("place_unit", get_parent(), "_on_place_unit")

func _pressed():
	emit_signal("place_unit", unit_name)
