extends KinematicBody

export var maxSpeed = 15
var currentSpeed = 0
var currentVel = Vector3()

func _physics_process(delta):
	# Determine direction
	var direction = Vector3()
	if Input.is_action_pressed("move_down"):
		direction.z = 1
	if Input.is_action_pressed("move_up"):
		direction.z = -1
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	if Input.is_action_pressed("move_right"):
		direction.x = 1
	
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
			
	print(str(currentSpeed) +  " " + str(direction))
	move_and_slide(currentVel)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
