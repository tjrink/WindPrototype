extends Node 

# Preload the platform scene template for efficient instancing
const PLATFORM_SCENE = preload("res://platform.tscn")

# Define the level layout data using FLOAT values (e.g., 50.0 instead of 50)

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
	},
	{
		"profile_path": "res://PlatformClasses/RedPlatform.tres",
		"x": -350,
		"y": -100
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
		
