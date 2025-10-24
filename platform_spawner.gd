extends Node 

# Preload the platform scene template for efficient instancing
const PLATFORM_SCENE = preload("res://platform.tscn")

# Define the level layout data using FLOAT values (e.g., 50.0 instead of 50)
# NOTE: Y coordinates - smaller Y = higher on screen
# Ground is at Y=300, so platforms should be ABOVE that (smaller Y values)
const PLATFORM_DATA = [
	# Platform 1: Near the player position for easy testing
	{ 
		"x": 0.0,      # Center of screen
		"y": 200.0,    # Above ground (ground is at 300)
		"width":300.0, 
		"height": 50.0, 
		"travel": 50.0, 
		"speed": 1.0 
	}, 
	# Platform 2: To the right
	{ 
		"x": 400.0, 
		"y": 100.0,    # Higher up
		"width": 300.0, 
		"height": 50.0, 
		"travel": 100.0, 
		"speed": 0.5 
	},
	# Platform 3: To the left
	{ 
		"x": -400.0, 
		"y": 150.0,    # Mid height
		"width": 300.0, 
		"height": 50.0, 
		"travel": 75.0, 
		"speed": 1.5 
	},
]

func _ready() -> void:
	# Use call_deferred to ensure scene tree is fully ready
	call_deferred("spawn_all_platforms")

func spawn_all_platforms():
	
	for i in range(PLATFORM_DATA.size()):
		var data = PLATFORM_DATA[i]
		
		# 1. Instantiate the scene template
		var platform_instance = PLATFORM_SCENE.instantiate()
		

		# 2. Set the built-in position property BEFORE adding to tree
		platform_instance.position = Vector2(data.x, data.y)
		
		# 3. Set the custom exported variables defined in platform.gd BEFORE adding to tree
		platform_instance.platform_width = data.width
		platform_instance.platform_height = data.height
		platform_instance.max_travel = data.travel
		platform_instance.cycle_speed = data.speed
		
		# 4. Add platform to scene tree (this should trigger _ready())
		get_parent().add_child(platform_instance)
		
