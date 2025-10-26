extends Node 

# Preload the platform scene template for efficient instancing
const TOKEN_SCENE = preload("res://token.tscn")

const MIN_X: float = -500.0
const MAX_X: float = 500.0
const MIN_Y: float = -300.0
const MAX_Y: float = 200.0


func _ready() -> void:
	# Use call_deferred to ensure scene tree is fully ready
	call_deferred("spawn_token")

#Loops through all platforms listed in the PLATFORM_DATA const and makes a platform with the specifications
func spawn_token():
	
		##Creates a token at a random position
		var token_instance = TOKEN_SCENE.instantiate()
		token_instance.x_position = randf_range(MIN_X, MAX_X)
		token_instance.y_position = randf_range(MIN_Y, MAX_Y)

		#Add token to scene tree
		get_parent().add_child(token_instance)
		
