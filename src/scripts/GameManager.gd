extends Node

signal pause()
signal unpause()

func pause_game():
	get_tree().paused = true
	emit_signal("pause")
	
func unpause_game():
	get_tree().paused = false
	emit_signal("unpause")
