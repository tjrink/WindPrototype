extends Node 

# Preload the platform scene template for efficient instancing
const PLATFORM_SCENE = preload("res://platform.tscn")

# Define the level layout data using FLOAT values (e.g., 50.0 instead of 50)
# NOTE: Y coordinates - smaller Y = higher on screen
# Ground is at Y=300, so platforms should be ABOVE that (smaller Y values)
#const PLATFORM_DATA = [
	## Platform 1: Near the player position for easy testing
	#{ 
		#"x": 0.0,      # Center of screen
		#"y": 0.0,    # Above ground (ground is at 300)
		#"width":100.0, 
		#"height": 50.0, 
		#"travel": 200.0, 
		#"speed": 2.0,
		#"color": Color(0.6, 0.4, 0.2, 1.0)
	#}, 
	## Platform 2: To the right
	#{ 
		#"x": 400.0, 
		#"y": 100.0,    # Higher up
		#"width": 200.0, 
		#"height": 50.0, 
		#"travel": 100.0, 
		#"speed": 0.5,
		#"color": Color(0.6, 0.4, 0.2, 1.0) 
	#},
	## Platform 3: To the left
	#{ 
		#"x": -400.0, 
		#"y": 0.0,    # Mid height
		#"width": 100.0, 
		#"height": 50.0, 
		#"travel": 75.0, 
		#"speed": 1.5,
		#"color": Color(0.6, 0.4, 0.2, 1.0)
	#}
#]

const PLATFORM_DATA = [
	{
		"profile_path": "res://PlatformClasses/BluePlatform.tres",
		"x": 400,
		"y": 0
	},
	{
		"profile_path":  "res://PlatformClasses/BluePlatform.tres",
		"x": -500,
		"y": 50
	},
	{
		"profile_path": "res://PlatformClasses/RedPlatform.tres",
		"x": 200,
		"y": 0
	},
	{
		"profile_path": "res://PlatformClasses/BrownPlatform.tres",
		"x": -100,
		"y": 0
	}
]

func _ready() -> void:
	# Use call_deferred to ensure scene tree is fully ready
	call_deferred("spawn_all_platforms")

#Loops through all platforms listed in the PLATFORM_DATA const and makes a platform with the specifications
func spawn_all_platforms():
	
	for i in range(PLATFORM_DATA.size()):
		var data = PLATFORM_DATA[i]
		var loaded_resource = load(data.profile_path)
		#Instantiate the scene template
		var platform_instance = PLATFORM_SCENE.instantiate()
		
#
		#Set the built-in position property BEFORE adding to tree
		platform_instance.position = Vector2(data.x, data.y)
		
		# Sets clas specific variables before adding tree to parent
		platform_instance.platform_width = loaded_resource.width
		platform_instance.platform_height = loaded_resource.height
		platform_instance.max_travel = loaded_resource.amplitude
		platform_instance.cycle_speed = loaded_resource.speed
		platform_instance.platform_color = loaded_resource.platform_color
		
		#Add platform to scene tree
		get_parent().add_child(platform_instance)
		
