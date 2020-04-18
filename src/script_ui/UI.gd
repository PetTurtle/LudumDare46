extends CanvasLayer
class_name UI

#signal mode_default()
signal mode_buy(unit_name)
signal mode_sell()

onready var tower_container = $TowerContainer

func _ready():
	tower_container.connect("place_unit", self, "_on_place_unit")
	tower_container.connect("mode_sell", self, "_on_mode_sell")

func _on_place_unit(unit_name):
	emit_signal("mode_buy", unit_name)
	
func _on_mode_sell():
	emit_signal("mode_sell")
