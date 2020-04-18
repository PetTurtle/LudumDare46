extends Resource
class_name TowerDef

export(String) var name = "Tower"
export(int) var cost = 1
export(bool) var recursively_fire = false
export(Texture) var texture = null
export(Array, Vector2) var fireDirections
