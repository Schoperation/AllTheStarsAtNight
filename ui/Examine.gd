extends Label

"""
Functions that help the player examine the whereabouts of their world.
"""
signal examineMouseEnter(object, objectName)
signal examineMouseExit(object, objectName)
var mouseObj = null

func _process(delta):
	# Set text to mousecoords
	var mouseCoords = get_viewport().get_mouse_position()
	get_parent().set_position(mouseCoords)

func onMouseEnter(object, objectName):
	
	# What if there's an overlap?
	if mouseObj != null:
		onMouseExit()
	
	text = "Examine " + objectName
	mouseObj = object
	
	# Highlight the object
	if mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 0.70
		
		
func onMouseExit():
	text = ""
	
	# Unhighlight the object
	if mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 1.00
		
	mouseObj = null
