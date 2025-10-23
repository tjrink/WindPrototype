extends Node2D

const LEFT_EDGE = 0
const RIGHT_EDGE = 1200


func _process(delta: float) -> void:
	#Gets wind speed for cloud at position y
	var wind_speed = Wind.get_wind_speed_at_y(position.y) 
	
	# Move the cloud horizontally (Wind Speed * Time)
	position.x += wind_speed * delta 

	# Clean up clouds off the screen
	if position.x > RIGHT_EDGE or position.x < LEFT_EDGE:
		queue_free()
