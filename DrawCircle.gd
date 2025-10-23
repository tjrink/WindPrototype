extends Node2D

# Set the radius to match CollisionShape2D
const BALL_RADIUS = 20.0 
const BALL_COLOR = Color(0.905882, 0.435294, 0.317647) # Orange-red color

#Draws circle
func _draw():
	draw_circle(Vector2.ZERO, BALL_RADIUS, BALL_COLOR)
