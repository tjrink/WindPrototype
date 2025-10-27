extends Area2D

@export var scale_width: float = 1.0
@export var scale_height: float = 1.0
@export var x_position: float = 200.0
@export var y_position: float = 100.0

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
	var sprite = $TokenSprite	
	sprite.scale = Vector2(scale_width, scale_height)




func _on_body_entered(body: Node2D) -> void:
	#Adds 1 to game_score if player enters token
	if body.is_in_group("player"):
		Global.game_score+=1
		queue_free()

func _on_body_exited(body: Node2D) -> void:
	#Eliminates token when player exits
	if body.is_in_group("player"):
		queue_free()
