extends StaticBody2D

@export var ground_width: float = 2000.0
@export var ground_height: float = 50.0

@export var ground_x: float = -1000.0
@export var ground_y: float = 360.0

@export var ground_color: Color = Color(1, 0.25, 0.25, 1)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Create new ColorRect object to display the ground
	var color_rect = ColorRect.new()
	color_rect.size = Vector2(ground_width, ground_height)
	color_rect.color = ground_color
	
	#Create collision shape for the ground
	var ground_collision = CollisionShape2D.new()
	var collision_shape = RectangleShape2D.new()
	collision_shape.extents = Vector2(ground_width, ground_height)
	ground_collision.shape = collision_shape
	
	var ground_area = Area2D.new()
	var ground_area_collision = CollisionShape2D.new()
	var ground_area_collision_shape = RectangleShape2D.new()
	ground_area_collision_shape.extents = Vector2(ground_width, ground_height)
	ground_area_collision.shape = ground_area_collision_shape
	ground_area.add_child(ground_area_collision)

	
	
	
	
	add_child(color_rect)
	add_child(ground_collision)
	add_child(ground_area)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
