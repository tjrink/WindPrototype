extends Node 

# Preload the platform scene template for efficient instancing
const PLATFORM_SCENE = preload("res://platform.tscn")

# Define the level layout data using FLOAT values (e.g., 50.0 instead of 50)
const PLATFORM_DATA = [
	# Platform 1: x, y, width, height, max_travel, cycle_speed
	{ 
		"x": 100.0, 
		"y": 500.0, 
		"width": 300.0, 
		"height": 50.0, 
		"travel": 50.0, 
		"speed": 1.0 
	}, 
	# Platform 2
	{ 
		"x": 450.0, 
		"y": 450.0, 
		"width": 200.0, 
		"height": 50.0, 
		"travel": 100.0, 
		"speed": 0.5 
	},
	# Platform 3
	{ 
		"x": 800.0, 
		"y": 400.0, 
		"width": 400.0, 
		"height": 50.0, 
		"travel": 75.0, 
		"speed": 1.5 
	},
]

func _ready() -> void:
	print("Spawner starting")
	spawn_all_platforms()
	print("Spawner complete")

func spawn_all_platforms():
	for data in PLATFORM_DATA:
		# 1. Instantiate the scene template
		var platform_instance = PLATFORM_SCENE.instantiate()
		print(platform_instance)
		
		# 2. Set the built-in position property
		platform_instance.position = Vector2(data.x, data.y)
		
		# 3. Set the custom exported variables defined in platform.gd
		platform_instance.platform_width = data.width
		platform_instance.platform_height = data.height
		
		#Sets movement variables for platforms from data
		platform_instance.max_travel = data.travel
		platform_instance.cycle_speed = data.speed
		
		#Add platform to main scene
		get_parent().add_child(platform_instance)
