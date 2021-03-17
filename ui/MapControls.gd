extends Camera

"""
Script for zooming and rotating the map
"""

# Keep track of where we are
var t = 1 # zoom
var r = 0 # rotate
var defaultPos

func _ready():
	defaultPos = self.transform.origin
	changeCameraPos()

func _input(event):
	if Input.is_action_just_released("zoom_in"):
		if t > 0:
			t -= 0.1
			
			# Only call the method if it isn't already being called by rotation
			if r == -10 or r == 0 or r == 10:
				changeCameraPos()
		elif t < 0:
			t = 0
			changeCameraPos()
	elif Input.is_action_just_released("zoom_out"):
		if t < 2.0:
			t += 0.1
			
			if r == -10 or r == 0 or r == 10:
				changeCameraPos()
		elif t > 2.0:
			t = 2.0
			changeCameraPos()

# For smoother rotation
func _process(delta):
	# To "snap" back from rotated view
	if r > 0 and not Input.is_action_pressed("rotate_right"):
		r -= 0.5 * (1 - r/10.5)
		changeCameraPos()
	elif r < 0 and not Input.is_action_pressed("rotate_left"):
		r += 0.5 * (1 + r/10.5)
		changeCameraPos()
	# Actual rotation
	elif Input.is_action_pressed("rotate_left"):
		if r > -10:
			r -= 0.5 * (1 + r/10.5) # Slow down as we approach limit
			changeCameraPos()
		elif r < -10:
			r = -10
			changeCameraPos()
	elif Input.is_action_pressed("rotate_right"):
		if r < 10:
			r += 0.5 * (1 - r/10.5)
			changeCameraPos()
		elif r > 10:
			r = 10
			changeCameraPos()
				
	# Deadzone
	if r > -0.3 and r < 0.3 and r != 0:
		r = 0
		changeCameraPos()
			
func changeCameraPos():
	# Follow a parabola
	var parabolaZ = 0.5 * (t + 1.5)
	var parabolaY = 0.5 * t * t + 0.25
	self.transform.origin.z = defaultPos.z * parabolaZ - abs(0.5 * r) + 1
	self.transform.origin.y = defaultPos.y * parabolaY
	self.transform.origin.x = r

	look_at(get_parent().transform.origin, Vector3(0, 1, 0))
	changeAngles()

func changeAngles():
	var angle = atan(self.transform.origin.x / abs(self.global_transform.origin.z - get_parent().transform.origin.z))
	
	# Player
	get_parent().get_node("AnimatedSprite3D").rotation = Vector3(get_parent().get_node("AnimatedSprite3D").rotation.x, angle, 0)
	
	for item in get_tree().get_nodes_in_group("Environment_Objs"):
		item.get_node("AnimatedSprite3D").rotation = Vector3(item.get_node("AnimatedSprite3D").rotation.x, angle * 0.75, 0)

	for item in get_tree().get_nodes_in_group("Followers"):
		item.get_node("AnimatedSprite3D").rotation = Vector3(item.get_node("AnimatedSprite3D").rotation.x, angle, 0)
