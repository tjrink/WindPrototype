extends StaticBody2D

# Exported variables that can be set by the spawner
@export var platform_width: float = 100.0
@export var platform_height: float = 50.0
@export var max_travel: float = 0.0
@export var cycle_speed: float = 1.0

func _ready() -> void:
	print("✅ PLATFORM _READY() FIRED! Instantiation SUCCESSFUL.")
	print("  Position: ", position)
	print("  Width: ", platform_width, " Height: ", platform_height)
	setup_initial_size()

func setup_initial_size():
	# Get references to child nodes
	var rect = $PlatformRect
	var collision = $PlatformCollision
	
	# Set the visual rectangle size
	rect.size = Vector2(platform_width, platform_height)
	# Center the rectangle on the platform's origin
	rect.position = Vector2(-platform_width / 2, -platform_height / 2)
	
	# Set the collision shape size
	var shape = collision.shape as RectangleShape2D
	shape.size = Vector2(platform_width, platform_height)
	# Collision shape is already centered by default
