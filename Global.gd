extends Node

@export var game_score: int = 0
var is_game_over: bool = false
var needs_respawn: bool = false

var game_over_scene = preload("res://game_over.tscn")
var player_instance = null
var scoreboard_instance = null

func _ready() -> void:
	# Connect to scene tree to detect scene changes
	get_tree().node_added.connect(_on_node_added)
	
	# Wait for the scene tree to be ready
	await get_tree().process_frame
	spawn_game_elements()

func _on_node_added(node: Node) -> void:
	# Check if the main scene was reloaded by looking for the MainScene root
	if needs_respawn and node.name == "MainScene":
		needs_respawn = false
		call_deferred("spawn_game_elements")

func spawn_game_elements():
	# Get the root of the current scene
	var root = get_tree().current_scene
	
	if root == null:
		push_error("No current scene found!")
		return
	
	# Find the World node (or use root if World doesn't exist)
	var world_node = root.get_node_or_null("World")
	var parent = world_node if world_node else root
	
	# Clean up old scoreboard
	if scoreboard_instance != null and is_instance_valid(scoreboard_instance):
		scoreboard_instance.queue_free()
	
	# Spawn new scoreboard
	var scoreboard_scene = preload("res://scoreboard.tscn")
	scoreboard_instance = scoreboard_scene.instantiate()
	add_child(scoreboard_instance)
	
	# Clean up old player
	if player_instance != null and is_instance_valid(player_instance):
		player_instance.queue_free()
	
	# Spawn new player
	var player_scene = preload("res://player.tscn")
	player_instance = player_scene.instantiate()
	parent.add_child(player_instance)
	
	print("Player spawned at position: ", player_instance.position)

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
	needs_respawn = true  # Flag that we need to respawn after scene reload
	
	# Reset wind patterns
	Wind.reset_wind()
	
	# Remove any existing game over screen
	for child in get_children():
		if child.name == "GameOver":
			child.queue_free()
