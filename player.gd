extends CharacterBody2D

# Physics & Movement Constants
const GRAVITY_FORCE = 800.0
const BASE_SPEED = 300.0
const BASE_JUMP = -750.0
const AIR_DRAG_FACTOR = 0.3

const SPRINT_DURATION = 1.5
const SPRINT_SPEED_MULTIPLIER = 3.0
const SPRINT_JUMP_MULTIPLIER = 1.5
var sprint_time_remaining: float = 0.0
var sprints_available: int = 2


func _physics_process(delta: float) -> void:
	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY_FORCE * delta
	else:
		velocity.y = 0.0

	#Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = get_jump_velocity()
	
	#Applies sprint mode
	if Input.is_action_just_pressed("ui_sprint"):
		if sprints_available > 0:
			sprint_time_remaining = SPRINT_DURATION
			sprints_available -= 1

	#Input direction
	var direction := Input.get_axis("ui_left", "ui_right")
	var current_speed = get_current_speed()
	
	if direction:
		velocity.x = direction * current_speed
	else:
		#Deceleration
		velocity.x = move_toward(velocity.x, 0.0, current_speed)

	#Gets and applies wind force
	var wind_force_x = Wind.get_wind_speed_at_y(position.y)
	var wind_force_y = Wind.get_wind_speed_at_x(position.x)
	velocity.x = lerp(velocity.x, velocity.x + wind_force_x, 1000.0 * delta)
	velocity.y = lerp(velocity.y, velocity.y + wind_force_y, 100.0 * delta)
	#Move player
	move_and_slide()
	
	#Reduce sprint timer
	update_sprint_timer(delta)


#Track the time remaining in current sprint mode
func update_sprint_timer(delta: float):
	if sprint_time_remaining > 0.0:
		sprint_time_remaining -= delta

#Returns current speed based on sprint status
func get_current_speed() -> float:
	if sprint_time_remaining > 0.0:
		return BASE_SPEED * SPRINT_SPEED_MULTIPLIER
	return BASE_SPEED

#Returns jump height based on sprint status
func get_jump_velocity() -> float:
	if sprint_time_remaining > 0.0:
		return BASE_JUMP * SPRINT_JUMP_MULTIPLIER
	return BASE_JUMP
