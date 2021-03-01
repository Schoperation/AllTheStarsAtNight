extends Camera

"""
Script for zooming in and out of the map 

Also for changing the skybox color
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
	var parabolaY = 0.5 * t * t + 0.2
	self.transform.origin.z = defaultPos.z * parabolaZ + 1
	self.transform.origin.y = defaultPos.y * parabolaY
	self.transform.origin.x = r
	
	# Set angle
	# theta = arctan(z/y)
	#var theta = atan(parabolaY/(parabolaZ - 0.1)) * -1.1
	#self.rotation.x = theta
	
	look_at(get_parent().transform.origin, Vector3(0, 1, 0))
	print(self.global_transform.origin.distance_to(get_parent().transform.origin))
	print(self.global_transform.origin)
	
# Change skybox colors
func changeSkyColor():
	pass
