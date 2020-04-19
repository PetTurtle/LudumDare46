extends YSort
class_name Bullets

var bullet_prefab = load("res://prefabs/Bullet.tscn")
var gameMap : GameMap

func _ready():
	gameMap = get_parent().get_map()
	print(gameMap)

func create(pos : Vector2, moves : bool , direction : Vector2):
	var bullet : Bullet = bullet_prefab.instance()
	add_child(bullet)
	bullet.set_bullet(pos, moves, direction, gameMap)
