extends StaticBody2D

@export var ground_width: float = 2000.0
@export var ground_height: float = 50.0

@export var ground_x: float = 0.0
@export var ground_y: float = 360.0

@export var ground_color: Color = Color(0.545, 0.271, 0.075, 1)  # Brown ground color

@export var ground_strength: float = 100.0
var has_body_on: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	# Set the ground's position
	position = Vector2(ground_x, ground_y)
		
	# Create new ColorRect object to display the ground
	var color_rect = ColorRect.new()
	color_rect.size = Vector2(ground_width, ground_height)
	color_rect.position = Vector2(-ground_width / 2, -ground_height / 2)  # Center it
	color_rect.color = ground_color
	color_rect.z_index = 10  # Make sure it's above the sky
	add_child(color_rect)
		
	# Create collision shape for the ground (for solid collision)
	var ground_collision = CollisionShape2D.new()
	var collision_shape = RectangleShape2D.new()
	collision_shape.size = Vector2(ground_width, ground_height)
	ground_collision.shape = collision_shape
	add_child(ground_collision)
	
	# Create Area2D for detection
	var ground_area = Area2D.new()
	var ground_area_collision = CollisionShape2D.new()
	var ground_area_collision_shape = RectangleShape2D.new()
	ground_area_collision_shape.size = Vector2(ground_width, ground_height+1) #Ground area is offset by 1 to ensure landing is tracked
	ground_area_collision.shape = ground_area_collision_shape
	ground_area.add_child(ground_area_collision)
	
	# Connect the Area2D signal
	ground_area.body_entered.connect(_on_body_entered)
	ground_area.body_entered.connect(_on_body_exited)
	add_child(ground_area)


# Called when a body enters the ground area
func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			has_body_on = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		has_body_on = false
		print("Exited")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if has_body_on:
		ground_strength-=1
		
	if ground_strength < 0:
		position.y+=1
		
	if position.y > 500:
		queue_free()
