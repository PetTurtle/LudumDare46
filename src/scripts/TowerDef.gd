extends Resource
class_name TowerDef

export(String) var name = "Tower"
export(int) var cost = 1
export(bool) var recursively_fire = false
export(Array, Texture) var textures
export(Array, Vector2) var fireDirections

func get_default_texture() -> Texture:
	return textures[0]

func get_texture() -> Texture:
	return textures[randi() % textures.size()]
