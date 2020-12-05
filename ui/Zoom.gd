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
		print(t)
		changeCameraPos()
	elif Input.is_action_just_released("zoom_out"):
		t += 0.1
		print(t)
		changeCameraPos()
		
func changeCameraPos():
	self.transform.origin = defaultPos * t
