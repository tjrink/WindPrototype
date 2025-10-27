extends Node2D

const LEFT_EDGE = -600
const RIGHT_EDGE = 600

@export var starting_x: float
@export var starting_y: float

func _ready() -> void:
	position.x = starting_x
	position.y = starting_y


func _process(delta: float) -> void:
	#Gets wind speed for cloud at position y
	var wind_speed = Wind.get_wind_speed_at_y(position.y) 
	
	# Move the cloud horizontally (Wind Speed * Time)
	position.x += wind_speed * delta 

	# Clean up clouds off the screen
	if position.x > RIGHT_EDGE or position.x < LEFT_EDGE:
		queue_free()
