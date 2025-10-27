extends Area2D

func _ready():
	print("Dynamic Area2D is ready!")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	print("Body entered: ", body.name)
	 
