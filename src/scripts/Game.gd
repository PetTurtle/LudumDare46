extends Node2D

enum Mode {
	IDLE,
	BUY,
	SELL,
}

onready var ui : UI = $UI
onready var towers : Towers = $Towers
onready var map : GameMap = $Map1 # TODO LEVEL Loading System

var mode : int = Mode.IDLE
var tower_name : String

func _ready():
	ui.connect("mode_buy", self, "_on_mode_buy")
	ui.connect("mode_sell", self, "_on_mode_sell")

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return

	if event.button_index == BUTTON_LEFT:
		match mode:
			Mode.IDLE: # ____IDLE____
				pass
			Mode.BUY: # ____BUY____
				if map.can_build_turret():
					map.build_turret()
					towers.create(tower_name, map.get_snapped_mouse_position())
			Mode.SELL: # ____SELL____
				if map.has_turret():
					map.clear_turret()
					towers.remove_at(map.get_snapped_mouse_position())
	elif event.button_index == BUTTON_RIGHT:
		match mode:
			Mode.IDLE: # ____IDLE____
				pass
			Mode.BUY: # ____BUY____
				mode = Mode.IDLE
			Mode.SELL: # ____SELL____
				mode = Mode.IDLE
		

func _on_mode_buy(name):
	mode = Mode.BUY
	tower_name = name
	
func _on_mode_sell():
	print("SELL")
	mode = Mode.SELL
