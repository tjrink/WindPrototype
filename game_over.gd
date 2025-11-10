extends CanvasLayer

func _ready() -> void:
	# Pause the game when game over shows
	get_tree().paused = true
	
	# Update the score label
	$Panel/VBoxContainer/ScoreLabel.text = "Final Score: " + str(Global.game_score)

func _on_restart_button_pressed() -> void:
	# Reset game state
	Global.game_score = 0
	Global.is_game_over = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
