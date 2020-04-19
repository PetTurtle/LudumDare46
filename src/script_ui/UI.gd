extends CanvasLayer
class_name UI

#signal mode_default()
signal mode_buy(unit_name)
signal mode_sell()
signal next_wave()

onready var tower_container = $TowerContainer
onready var next_wave_container = $NextWaveContainer

func _ready():
	tower_container.connect("place_unit", self, "_on_place_unit")
	tower_container.connect("mode_sell", self, "_on_mode_sell")
	next_wave_container.connect("next_wave", self, "_on_next_wave")

func _on_place_unit(unit_name):
	emit_signal("mode_buy", unit_name)
	
func _on_mode_sell():
	emit_signal("mode_sell")

func _on_next_wave():
	emit_signal("next_wave")
