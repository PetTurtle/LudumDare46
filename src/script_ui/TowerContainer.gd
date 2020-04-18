extends HBoxContainer

signal place_unit(name)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for i in range(children.size()):
		children[i].connect("place_unit", self, "_on_place_unit")

func show_towers():
	pass

func hide_towers():
	pass
	
func _on_place_unit(unit_name):
	emit_signal("place_unit", unit_name)
