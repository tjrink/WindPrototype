extends StaticBody2D

# Exported variables that can be set by spawning script

#Platform construction details
@export var platform_width: float = 100.0 #Start x
@export var platform_height: float = 50.0 #Start Y position
@export var platform_color: Color = Color()

#Platform movement details
@export var max_travel: float = 150.0 #Amplitude - how much variance can the platform see from it's starting point
@export var cycle_speed: float = 1.0 #Cycle frequency

#Platform change details
@export var shrink_rate = 50.0 # Units per second to shrink
@export var growth_rate = 10.0  # Units per second to grow
@export var initial_offset: float = 0.0 # Use this to stagger movement if you have multiple platforms

#Management of platform sate
var time_elapsed: float = 0.0
var start_y: float = 0.0

# Platform sizing/resizing properties
const FALL_THRESHOLD: float = 3.0 #platform width at which the player will fall through

var min_width = 1.0 
var max_width: float   # This will store the initial platform_width as the maximum size


var player_is_on: bool = false #Tracks whether the player object is on the platform

# References to shape resources
var platform_shape: RectangleShape2D
var area_shape: RectangleShape2D

func _ready() -> void:
	start_y = position.y #Sets tracking to internal position
	time_elapsed = initial_offset #Sets tracking to initial offset
	
	# Set the maximum size based on the initial width set by the spawner
	max_width = platform_width
	_setup_initial_shapes()


# Creates the necessary shapes with initial values
func _setup_initial_shapes():
	# Get references to child nodes
	var collision = $PlatformCollision
	var area_collision = $PlatformArea/AreaCollision
		
	# StaticBody2D collision shape
	platform_shape = RectangleShape2D.new()
	collision.shape = platform_shape
	collision.position = Vector2(0, 0)
	
	# Area2D collision shape
	area_shape = RectangleShape2D.new()
	area_collision.shape = area_shape
	area_collision.position = Vector2(0, 0)
	
	# Set a visible color 
	var rect = $PlatformRect
	rect.color = platform_color
	
	# Apply the initial width to all parts
	_update_platform_size()


# Updats size and location of all nodes in accordance with changing platform size
func _update_platform_size():
	#Width is clamped between boundary values to keep it from getting too large or small
	platform_width = clamp(platform_width, min_width, max_width)

	#Update the shape size
	platform_shape.size.x = platform_width
	platform_shape.size.y = platform_height
	
	# Area Collision size is set
	# Set slightly larger than the area shape to ensure collisions are detected
	area_shape.size.x = platform_width + 0.1
	area_shape.size.y = platform_height + 0.1
	
	#Updates the PlatformRect (visual) size
	var rect = $PlatformRect
	rect.size = Vector2(platform_width, platform_height)
	
	# Update position to keep the platform visually centered around (0,0)
	rect.position.x = -platform_width / 2
	rect.position.y = -platform_height / 2
	

#Shrinks the platform whenever the player is on a platform
func shrink_platform(delta: float):
	if platform_width > min_width:
		# Decrease width, of the platform
		platform_width -= shrink_rate * delta
		
		#Sets a minimum size where the player can stand on the platform to prevent camping in the center
		#If the platform size falls under, collision logic is disabled until it is larger again
		#TODO: Make platform disappear if under threshold and reappear above a threshold
		if platform_width < FALL_THRESHOLD:
			collision_layer = 0
			collision_mask = 0
		else:
			collision_layer = 1
			collision_mask = 1

			
		_update_platform_size()

#Grows the platform size when player is not on object
func grow_platform(delta: float):
	if platform_width < max_width:
		platform_width += growth_rate * delta
		_update_platform_size()


func _process(delta: float):
	
	#Moves platforms across sine wave
	time_elapsed+=delta #Keeps time_elapsed in sync with game time
	var y_offset = sin(time_elapsed * cycle_speed) * max_travel #Calculate offset in sine wave
	position.y = clamp(start_y + y_offset, -250, 200) #Moves platform
	

	#Shrinks the platform when the player is on it, grows it when player is off
	if player_is_on:
		shrink_platform(delta)
	else:
		grow_platform(delta)


#Sets the player_is_on to true when player entersc
func _on_platform_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_on = true

#Sets the player_in_on to false when player exits
func _on_platform_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_is_on = false
