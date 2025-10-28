extends Node


@export var game_score: int = 0


func _ready() -> void:
	var scoreboard_scene = preload("res://scoreboard.tscn")
	var scoreboard_instance = scoreboard_scene.instantiate()
	add_child(scoreboard_instance)
	
	var player_scene = preload("res://player.tscn")
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	var ground_scene = preload("res://ground.tscn")
	var ground_instance = ground_scene.instantiate()
	add_child(ground_instance)
	
	
