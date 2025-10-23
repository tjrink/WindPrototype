extends Node

# Define the wind tranches: [Max Y (bottom of tranche), Wind Speed]
const WIND_TRANCHES = [
	[150.0, 80.0], 
	[350.0, 40.0],  
	[600.0, 10.0], 
]

#Returns the wind speed at given y position
func get_wind_speed_at_y(y_position: float) -> float:
	for tranche in WIND_TRANCHES:
		var max_y = tranche[0]
		var speed = tranche[1]
		
		if y_position <= max_y:
			return speed
			
	# Default return if position is outside defined tranches
	return 0.0
