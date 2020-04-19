extends Panel

signal next_wave()

onready var button : Button = $NextWaveButton
onready var animation : AnimationPlayer = $AnimationPlayer

func _ready():
	button.connect("pressed", self, "_on_pressed")

func _on_pressed():
	emit_signal("next_wave")
	show_panel(false)

func show_panel(value : bool):
	if value:
		animation.play("Open")
	else:
		animation.play_backwards("Open")
