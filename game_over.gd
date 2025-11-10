extends CanvasLayer

func _ready() -> void:
	# Pause the game when game over shows
	get_tree().paused = true
	
	# Update the score label
	$Panel/VBoxContainer/ScoreLabel.text = "Final Score: " + str(Global.game_score)

func _on_restart_button_pressed() -> void:
	print("Restart pressed")
	
	# Unpause first
	get_tree().paused = false
	
	# Reset game state in Global
	Global.reset_game()
	
	# Reload the scene
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
