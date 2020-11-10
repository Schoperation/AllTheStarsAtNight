extends KinematicBody

export var maxSpeed = 15
var currentSpeed = 0

func _physics_process(delta):
	var velocity = Vector3()
	if Input.is_action_pressed("move_down"):
		velocity.z += 1
	if Input.is_action_pressed("move_up"):
		velocity.z -= 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right") and currentSpeed > 0:
		currentSpeed -= 0.5
	elif currentSpeed < 0:
		currentSpeed = 0
	elif currentSpeed <= maxSpeed:
		currentSpeed += 0.5
		
	if not is_on_floor():
		velocity.y -= 0.5
	velocity = velocity.normalized() * currentSpeed
	move_and_slide(velocity)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
