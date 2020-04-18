extends Node2D

onready var pathFinder : PathFinder = $PathFinder
onready var units : Units = $Units
onready var towers : Towers = $Towers
onready var ui : UI = $UI

enum Mode {
	Default,
	Place,
	Sell
}

var mode : int = Mode.Default
var placeObject = ""

func _ready():
	ui.connect("mode_default", self, "_on_mode_default")
	ui.connect("mode_place", self, "_on_mode_place")
	ui.connect("mode_remove", self, "_on_mode_remove")

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	if not event.is_pressed():
		return

	if event.button_index == BUTTON_LEFT:
		if mode == Mode.Place:
			var placePos = get_global_mouse_position()
			if pathFinder.can_place_tower(placePos):
				pathFinder.block_cell(get_global_mouse_position(), -1)
			
	elif event.button_index == BUTTON_RIGHT:
		if mode != Mode.Default:
			mode = Mode.Default

func _on_mode_default() -> void:
	mode = Mode.Default

func _on_mode_place(name) -> void:
	print(name)
	mode = Mode.Place
	placeObject = name
	
func _on_mode_remove() -> void:
	mode = Mode.Remove
