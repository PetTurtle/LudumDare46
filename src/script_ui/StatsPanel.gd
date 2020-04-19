extends Panel

onready var animation : AnimationPlayer = $AnimationPlayer

func show_panel(value : bool):
	if value:
		animation.play("Open")
	else:
		animation.play_backwards("Open")
