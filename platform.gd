extends StaticBody2D

# Exported variables that can be set by the spawner
@export var platform_width: float = 100.0
@export var platform_height: float = 50.0
@export var max_travel: float = 0.0
@export var cycle_speed: float = 1.0

func _ready() -> void:
	setup_initial_size()

func setup_initial_size():
	# Get references to child nodes
	var rect = $PlatformRect
	var collision = $PlatformCollision
	
	# IMPORTANT: RectangleShape2D uses its size as the FULL width/height
	# NOT half-extents like some other engines
	
	# Set the collision shape size first
	var shape = collision.shape as RectangleShape2D
	if shape == null:
		push_error("Platform collision shape is not a RectangleShape2D!")
		return
	shape.size = Vector2(platform_width, platform_height)
	
	# CollisionShape2D with RectangleShape2D is centered at (0,0) by default
	# So we position the CollisionShape2D node at the platform's center
	collision.position = Vector2(0, 0)
	
	# Now set up the visual to match
	# ColorRect uses top-left positioning, so offset it to center it
	rect.size = Vector2(platform_width, platform_height)
	rect.position = Vector2(-platform_width / 2, -platform_height / 2)
	
	# Set a visible color (brown/tan for platforms)
	rect.color = Color(0.6, 0.4, 0.2, 1.0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player on")


func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Body off") # Replace with function body.
