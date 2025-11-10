extends Node 

# Preload the platform scene template for efficient instancing
const PLATFORM_SCENE = preload("res://platform.tscn")

# Define the level layout data using FLOAT values (e.g., 50.0 instead of 50)


func _ready() -> void:
	# Use call_deferred to ensure scene tree is fully ready
	call_deferred("spawn_all_ground")

#Loops through all platforms listed in the PLATFORM_DATA const and makes a platform with the specifications
func spawn_all_ground():
	var index_x: float = -650.0
	const max_x: float = 2000.0
	
	await get_tree().process_frame
	var root = get_tree().current_scene	
	var world_node = root.get_node_or_null("World")
	var parent = world_node if world_node else root
	var ground_scene = preload("res://ground.tscn")
	
	while (index_x <= max_x):
		var ground_instance = ground_scene.instantiate()
		var rand_width = randi_range(10, 250)
		var rand_red = randf_range(0.55, 0.70)
		var rand_blue = randf_range(0.05, 0.2)
		var rand_green = randf_range(0.35, 0.5)
		
		ground_instance.ground_x = index_x + rand_width / 2.0
		ground_instance.ground_width = rand_width		
		ground_instance.ground_color = Color(rand_red, rand_green, rand_blue, 1)	
		
		parent.add_child(ground_instance)
		
		index_x+=rand_width
		
