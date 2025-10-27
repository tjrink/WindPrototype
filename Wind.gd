extends Node


const MIN_Y: float = -350.0
const MAX_Y: float = 300

const MIN_X: float = -650
const MAX_X: float = 650

const MAX_WIND: float = 10.0


# Define the wind tranches: [Max Y (bottom of tranche), Wind Speed]
var WIND_TRANCHES_HORIZONTAL = []
var WIND_TRANCHES_VERTICAL = []
func _ready() -> void:
	generate_tranches()



func generate_tranches():
	randomize()
	
	#Sets the base wind speed
	#The higher the absolute value of the wind, the stronger it blows
	#Negative wind blows left, positive to the right
	var base_wind = randf_range(-MAX_WIND, MAX_WIND) #Sets a base wind value
	
	#Performs base tranche generation
	#Each generation uses the following pattern:
	#Index is set at the lowest possible value
	#Generates a random breaking point between the index and maximum value
	#Makes a small change to the base wind and resets the base wind and index values
	#Repeats until past maximum value
	generate_horizontal_tranches(base_wind)
	generate_vertical_tranches(base_wind)
			
func generate_horizontal_tranches(base_wind):
	
	var idx_horizontal = MIN_Y
	
	while idx_horizontal < MAX_Y:
		var tranche_start = randf_range(idx_horizontal + 20, MAX_Y)
		base_wind = clamp(base_wind + randf_range(-3, 3), -MAX_WIND, MAX_WIND)
		WIND_TRANCHES_HORIZONTAL.append([idx_horizontal, tranche_start, base_wind])
		
		idx_horizontal = tranche_start

func generate_vertical_tranches(base_wind):
	var idx_vertical = MIN_X
	
	while idx_vertical < MAX_X:
		var tranche_start = randf_range(idx_vertical + 20, MAX_X)
		base_wind = clamp(base_wind + randf_range(-3, 3), -MAX_WIND, MAX_WIND)
		WIND_TRANCHES_VERTICAL.append([idx_vertical, tranche_start, base_wind])
		
		idx_vertical = tranche_start

#Returns the wind speed at given y position
func get_wind_speed_at_y(y_position: float) -> float:
	for tranche in WIND_TRANCHES_HORIZONTAL:
		var min_y = tranche[0]
		var max_y = tranche[1]
		var speed = tranche[2]
		
		if y_position <= max_y and y_position >= min_y:
			return speed
			
	# Default return if position is outside defined tranches
	return 0.0

#Returns the wind speed at given xposition
func get_wind_speed_at_x(x_position: float) -> float:
	for tranche in WIND_TRANCHES_VERTICAL:
		var min_x = tranche[0]
		var max_x = tranche[1]
		var speed = tranche[2]
		
		if x_position <= max_x and x_position >= min_x:
			return speed
			
	# Default return if position is outside defined tranches
	return 0.0
