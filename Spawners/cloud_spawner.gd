extends Node

const CLOUD_SCENE = preload("res://cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		call_deferred("spawn_cloud")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Randomly generates a new cloud
	if randi_range(1, 100) == 50:
		spawn_cloud()


#Spawns a cloud at a ranodm point
func spawn_cloud() -> void:
	##Creates a cloud at a random position
	var cloud_instance = CLOUD_SCENE.instantiate()
	cloud_instance.starting_x = randf_range(0, 1200)
	cloud_instance.starting_y = randf_range(-300, 300)
	cloud_instance.z_index = -100

	#Add cloud to scene tree
	get_parent().add_child(cloud_instance)
