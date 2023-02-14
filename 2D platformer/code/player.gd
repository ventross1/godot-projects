extends KinematicBody2D
var gravity : int = 400
var velocity = Vector2.ZERO
#const UP_direction := Vector2.UP
var speed = 150
var jump = -225
var wall_jump = 0
var direction = 0
var wall_jump_speed = 5000

func movement(delta):
	velocity.x = 0
	if is_on_floor():
		wall_jump = 0
	if Input.is_action_pressed("left"):
		direction = 1
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		direction = 0
		velocity.x += speed
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump
	velocity.y += gravity * delta
	velocity.x = lerp(velocity.x, 0, 0.2)
	velocity = move_and_slide(velocity, Vector2.UP)
	pass

func abilites(delta):
	#walljump
	if Input.is_action_just_pressed("jump") and !is_on_floor() and near_wall() and wall_jump < 3:
		velocity.y = jump
		wall_jump += 1
		if direction == 1:
			velocity.x += wall_jump_speed
			velocity.x = lerp(velocity.x, 0, 0.8)
			velocity = move_and_slide(velocity,Vector2.UP)
		else:
			velocity.x -= wall_jump_speed
			velocity.x = lerp(velocity.x,0, 0.8)
			velocity = move_and_slide(velocity,Vector2.UP)
	pass

func cooldowns(delta):
	pass
func set_direction():
	$wall.rotation_degrees = 180 * -direction

func near_wall():
	return $wall.is_colliding()

func _physics_process(delta):
	abilites(delta)
	cooldowns(delta)
	set_direction()
	movement(delta)
