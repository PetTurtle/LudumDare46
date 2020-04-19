extends Area2D

onready var collision_shape : CollisionShape2D = $CollisionShape2D

var game_manager : GameManager

func _ready():
	connect("area_entered", self, "collision")
	game_manager = get_node("/root/GameManager")

func collision(area):
	if area is Unit:
		game_manager.damage_king()
		area.damage(9999)
