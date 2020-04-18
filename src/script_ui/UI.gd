extends CanvasLayer
class_name UI

#signal mode_default()
signal mode_place(unit_name)
#signal mode_remove()

onready var tower_container = $TowerContainer

func _ready():
	tower_container.connect("place_unit", self, "_on_place_unit")

func _on_place_unit(unit_name):
	emit_signal("mode_place", unit_name)
