extends Node2D

enum Mode {
	IDLE,
	BUY,
	SELL,
}

onready var ui : UI = $UI
onready var towers : Towers = $Towers
onready var bullets : Bullets = $Bullets

var mode : int = Mode.IDLE
var tower_name : String
var map : GameMap

func _ready():
	ui.connect("mode_buy", self, "_on_mode_buy")
	ui.connect("mode_sell", self, "_on_mode_sell")
	map = get_node("Map1") # TODO LEVEL Loading System

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
		
func get_map() -> GameMap:
	return get_node("Map1") as GameMap

func _on_mode_buy(name):
	mode = Mode.BUY
	tower_name = name
	
func _on_mode_sell():
	mode = Mode.SELL
	
func _on_fire(pos, moves, direction):
	if map.is_pathable(pos):
		bullets.create(pos, moves, direction)
