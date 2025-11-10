extends Node

@export var game_score: int = 0
var is_game_over: bool = false

var game_over_scene = preload("res://game_over.tscn")

func _ready() -> void:
	# Wait for the scene tree to be ready
	await get_tree().process_frame
	
	# Get the root of the current scene
	var root = get_tree().current_scene
	
	if root == null:
		push_error("No current scene found!")
		return
	
	# Find the World node (or use root if World doesn't exist)
	var world_node = root.get_node_or_null("World")
	
	var parent = world_node if world_node else root
	
	var scoreboard_scene = preload("res://scoreboard.tscn")
	var scoreboard_instance = scoreboard_scene.instantiate()
	add_child(scoreboard_instance)
	
	var player_scene = preload("res://player.tscn")
	var player_instance = player_scene.instantiate()
	parent.add_child(player_instance)

func trigger_game_over():
	if is_game_over:
		return 
	is_game_over = true
	
	var game_over_instance = game_over_scene.instantiate()
	add_child(game_over_instance)

# Call this function to reset the game state
func reset_game():
	game_score = 0
	is_game_over = false
	
	# Remove any existing game over screen
	for child in get_children():
		if child.name == "GameOver":
			child.queue_free()
