extends CanvasLayer
class_name UI

#signal mode_default()
signal mode_buy(unit_name)
signal mode_sell()
signal next_wave(value)

onready var tower_container = $TowerContainer
onready var next_wave_container = $NextWaveContainer
onready var stats_panel = $StatsPanel
onready var menu_panel = $MenuPanel
onready var game_over_panel = $GameOverPanel

func _ready():
	tower_container.connect("place_unit", self, "_on_place_unit")
	tower_container.connect("mode_sell", self, "_on_mode_sell")
	next_wave_container.connect("next_wave", self, "_on_next_wave")
	mode_menu()
	

func mode_game():
	tower_container.show_panel(true)
	next_wave_container.show_panel(true)
	stats_panel.show_panel(true)
	game_over_panel.show_panel(false)
	menu_panel.show_panel(false)
	
func mode_game_over():
	tower_container.show_panel(false)
	next_wave_container.show_panel(false)
	stats_panel.show_panel(false)
	game_over_panel.show_panel(true)
	menu_panel.show_panel(false)
	
func mode_menu():
	tower_container.show_panel(false)
	next_wave_container.show_panel(false)
	stats_panel.show_panel(false)
	game_over_panel.show_panel(false)
	menu_panel.show_panel(true)

func _on_place_unit(unit_name):
	emit_signal("mode_buy", unit_name)
	
func _on_mode_sell():
	emit_signal("mode_sell")

func _on_next_wave():
	emit_signal("next_wave")
