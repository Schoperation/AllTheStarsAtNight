extends KinematicBody

export var maxSpeed = 15
var currentSpeed = 0
var currentVel = Vector3()
const GROUND_LEVEL = 2.35

func _ready():
	# Prevent their y from moving
	move_lock_y = true

func _physics_process(delta):
	# Determine direction and animation... if key up, do idle animation
	var direction = Vector3()
	if Input.is_action_pressed("move_down"):
		direction.z = 1
		$AnimatedSprite3D.animation = "walk_front"
	elif Input.is_action_just_released("move_down"):
		$AnimatedSprite3D.animation = "idle_front"

	if Input.is_action_pressed("move_up"):
		direction.z = -1
		$AnimatedSprite3D.animation = "walk_back"
	elif Input.is_action_just_released("move_up"):
		$AnimatedSprite3D.animation = "idle_back"

	if Input.is_action_pressed("move_left"):
		direction.x = -1
		
		if $AnimatedSprite3D.animation != "walk_front" and $AnimatedSprite3D.animation != "walk_back":
			$AnimatedSprite3D.animation = "walk_side"
		$AnimatedSprite3D.flip_h = true
	elif Input.is_action_just_released("move_left"):
		$AnimatedSprite3D.animation = "idle_side"

	if Input.is_action_pressed("move_right"):
		direction.x = 1
		
		if $AnimatedSprite3D.animation != "walk_front" and $AnimatedSprite3D.animation != "walk_back":
			$AnimatedSprite3D.animation = "walk_side"
		$AnimatedSprite3D.flip_h = false
	elif Input.is_action_just_released("move_right"):
		$AnimatedSprite3D.animation = "idle_side"
	
	print($AnimatedSprite3D.animation)
	# Accelerating
	if direction and currentSpeed < maxSpeed:
		currentSpeed += 0.5
	# Decelerating
	elif currentSpeed > 0:
		currentSpeed -= 1
		
	if currentSpeed < 0:
		currentSpeed = 0
		
	# Did we just stop pressing down a key?
	if not direction and currentVel:
		if currentSpeed == 0:
			currentVel = Vector3(0, 0, 0)
		else:
			currentVel = currentVel.normalized() * currentSpeed
	else:
		currentVel = direction.normalized() * currentSpeed
	move_and_slide(currentVel)
	
	# Make sure y doesn't change
	if transform.origin.y > GROUND_LEVEL:
		translate(Vector3(0, -0.2, 0))
	elif transform.origin.y < GROUND_LEVEL:
		transform.origin = Vector3(transform.origin.x, GROUND_LEVEL, transform.origin.z)

# When we enter the game end body
func _on_GameEnd_body_entered(body):
	if body == self:
		#get_tree().reload_current_scene()
		pass
