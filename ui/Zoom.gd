extends Camera

"""
Script for zooming in and out of the map 

Also for changing the skybox color
"""

signal onAngleChanged(angle)

# Keep track of where we are
var t = 1 # zoom
var r = 0 # rotate
var defaultPos

func _ready():
	defaultPos = self.transform.origin
	changeCameraPos()

func _input(event):
	if Input.is_action_just_released("zoom_in"):
		t -= 0.1
		if t < 0:
			t = 0
		changeCameraPos()
	elif Input.is_action_just_released("zoom_out"):
		t += 0.1
		if t > 2.0:
			t = 2.0
		changeCameraPos()
	elif Input.is_action_pressed("rotate_left"):
		r -= 1
		if r < -10:
			r = -10
		changeCameraPos()
	elif Input.is_action_pressed("rotate_right"):
		r += 1
		if r > 10:
			r = 10
		changeCameraPos()
			
func changeCameraPos():
	# Follow a parabola
	var parabolaZ = 0.5 * (t + 1.5)
	var parabolaY = 0.5 * t * t + 0.25
	self.transform.origin.z = defaultPos.z * parabolaZ + 1
	self.transform.origin.y = defaultPos.y * parabolaY
	self.transform.origin.x = r
	
	# Set angle
	# theta = arctan(z/y)
	#var theta = atan(parabolaY/(parabolaZ - 0.1)) * -1.1
	#self.rotation.x = theta
	
	look_at(get_parent().transform.origin, Vector3(0, 1, 0))
	changeAngles()

func changeAngles():
	var angle = sin(self.transform.origin.x / self.global_transform.origin.distance_to(get_parent().transform.origin))
	
	# Player
	get_parent().get_node("AnimatedSprite3D").rotation = Vector3(get_parent().get_node("AnimatedSprite3D").rotation.x, angle, 0)
	
	for item in get_tree().get_nodes_in_group("Environment_Objs"):
		item.get_node("AnimatedSprite3D").rotation = Vector3(item.get_node("AnimatedSprite3D").rotation.x, angle, 0)

	for item in get_tree().get_nodes_in_group("Followers"):
		item.get_node("AnimatedSprite3D").rotation = Vector3(item.get_node("AnimatedSprite3D").rotation.x, angle, 0)
