extends Node2D

enum Mode {
	IDLE,
	BUY,
	SELL,
}

onready var ui : UI = $UI
onready var towers : Towers = $Towers
onready var bullets : Bullets = $Bullets

var game_data : GameData
var mode : int = Mode.IDLE
var tower_name : String
var map : GameMap
var coins : int = 500

func _ready():
	ui.connect("mode_buy", self, "_on_mode_buy")
	ui.connect("mode_sell", self, "_on_mode_sell")
	ui.connect("next_wave", self, "_on_next_wave")
	map = get_node("Map1") # TODO LEVEL Loading
	map.connect("unit_killed", self, "_on_kill")
	ui.update_coins(coins)
	game_data = get_node("/root/GameData")
	
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
				var cost = game_data.get_tower_cost(tower_name)
				if map.can_build_turret() and cost <= coins:
					map.build_turret()
					towers.create(game_data.get_tower_def(tower_name), map.get_snapped_mouse_position())
					coins -= cost
					ui.update_coins(coins)
					game_data.add_tower(tower_name)
					
			Mode.SELL: # ____SELL____
				if map.has_turret():
					var pos : Vector2 = map.get_snapped_mouse_position()
					var tower_def : TowerDef = towers.tower_def_at(pos)
					var cost = game_data.get_tower_cost(tower_def.name)
					map.clear_turret()
					towers.remove_at(pos)
					coins += cost/2
					game_data.remove_tower(tower_def.name)
					ui.update_coins(coins)
					
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

func set_coins(amount : int):
	coins = amount
	ui.update_coins(amount)

func get_coins() -> int:
	return coins

func _on_mode_buy(name):
	mode = Mode.BUY
	tower_name = name
	
func _on_mode_sell():
	mode = Mode.SELL
	
func _on_fire(pos, moves, direction):
	if map.is_pathable(pos):
		bullets.create(pos, moves, direction)
		
func _on_next_wave():
	map.next_wave()

func _on_kill(value):
	set_coins(get_coins()+value)
