extends Camera

"""
Script for zooming in and out of the map 
"""

# Keep track of where we are
var t = 1
var defaultPos

func _ready():
	defaultPos = self.transform.origin

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
		
func changeCameraPos():
	# Follow a parabola
	var parabolaZ = 0.5 * (t + 1.5)
	var parabolaY = 0.5 * t * t + 0.25
	self.transform.origin.z = defaultPos.z * parabolaZ
	self.transform.origin.y = defaultPos.y * parabolaY
	
	# Set angle
	# theta = arctan(z/y)
	var theta = atan(parabolaY/(parabolaZ - 0.1)) * -1.1
	self.rotation.x = theta
