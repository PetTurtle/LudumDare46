extends Panel

signal next_wave()

onready var button : Button = $NextWaveButton

func _ready():
	button.connect("pressed", self, "_on_pressed")


func _on_pressed():
	emit_signal("next_wave")

func show_panel(value : bool):
	visible = value
