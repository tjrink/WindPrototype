extends Node


@export var game_score: int = 0


func _ready() -> void:
	var scoreboard_scene = preload("res://scoreboard.tscn")
	var scoreboard_instance = scoreboard_scene.instantiate()
	
	add_child(scoreboard_instance)
