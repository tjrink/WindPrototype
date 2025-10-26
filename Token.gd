extends Area2D

@export var scale_width: float = 1.0
@export var scale_height: float = 1.0
@export var x_position: float = 200.0
@export var y_position: float = 100.0

@export var game_score: int = 0

var is_scorable: bool = true

var sprite_shape
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = x_position
	position.y = y_position
	_setup_initial_shapes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_initial_shapes():
	# Get references to child nodes
	var sprite = $GearSprite
	
	sprite.scale = Vector2(scale_width, scale_height)


func _on_area_entered(area: Area2D) -> void:
	if is_scorable:
		game_score+=1
		print(game_score)
	
	is_scorable = false

func _on_area_exited(area: Area2D) -> void:
	is_scorable = true
