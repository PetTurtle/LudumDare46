extends Node2D

enum Mode {
	IDLE,
	BUY,
	SELL,
}

onready var ui : UI = $UI
onready var towers : Towers = $Towers
onready var bullets : Bullets = $Bullets
onready var tile_ghost : TileGhost = $TileGhost

var game_manager : GameManager
var game_data : GameData
var mode : int = Mode.IDLE
var tower_name : String
var map : GameMap

func _ready():
	game_data = get_node("/root/GameData")
	game_manager = get_node("/root/GameManager")
	ui.connect("mode_buy", self, "_on_mode_buy")
	ui.connect("mode_sell", self, "_on_mode_sell")
	ui.connect("next_wave", self, "_on_next_wave")
	game_manager.connect("game_start", self, "start_game")
	game_manager.connect("game_over", self, "game_over")
	game_manager.connect("main_menu", self, "end_game")
	
func _process(_delta):
	tile_ghost.hide_ghost()
	match mode:
		Mode.IDLE:
			pass
		Mode.BUY:
			if map.can_build_turret():
				var cost = game_data.get_tower_cost(tower_name)
				tile_ghost.show_ghost(map.get_snapped_mouse_position(), cost, game_data.get_tower_def(tower_name).get_default_texture())
		Mode.SELL:
			if map.has_turret():
				var cost = game_data.get_tower_cost(tower_name)
				tile_ghost.show_ghost(map.get_snapped_mouse_position(), cost/2)
				
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
				if map.can_build_turret() and cost <= game_manager.get_coins():
					map.build_turret()
					towers.create(game_data.get_tower_def(tower_name), map.get_snapped_mouse_position())
					game_manager.set_coins(game_manager.get_coins() - cost)
					game_data.add_tower(tower_name)
					
			Mode.SELL: # ____SELL____
				if map.has_turret():
					var pos : Vector2 = map.get_snapped_mouse_position()
					var tower_def : TowerDef = towers.tower_def_at(pos)
					var cost = game_data.get_tower_cost(tower_def.name)
					map.clear_turret()
					towers.remove_at(pos)
					game_manager.set_coins(game_manager.get_coins() + cost/2)
					game_data.remove_tower(tower_def.name)
					
	elif event.button_index == BUTTON_RIGHT:
		match mode:
			Mode.IDLE: # ____IDLE____
				pass
			Mode.BUY: # ____BUY____
				mode = Mode.IDLE
			Mode.SELL: # ____SELL____
				mode = Mode.IDLE
	
func start_game():
	ui.mode_game()
	bullets.set_map(map)
	tile_ghost.set_map(map)
	
func game_over():
	ui.mode_game_over()
	
func end_game():
	ui.mode_menu()
	game_data.clear_all()
	bullets.clear_all()
	towers.clear_all()
		
func load_map(map_prefab):
	if map != null:
		delete_map()
	map = map_prefab.instance()
	add_child(map)
		
func delete_map():
	map.queue_free()

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
