extends TileGhost

onready var attack_cells : Node2D = $AttackCells

func show_ghost(texture : Texture = x_texture):
	.show_ghost(texture)
	attack_cells.draw_cells()

func hide_ghost():
	.hide_ghost()
	attack_cells.clear_cells()
