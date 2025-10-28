extends Node


@export var game_score: int = 0


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
	
	var ground_scene = preload("res://ground.tscn")
	var ground_instance = ground_scene.instantiate()
	parent.add_child(ground_instance)
	
	var player_scene = preload("res://player.tscn")
	var player_instance = player_scene.instantiate()
	parent.add_child(player_instance)
