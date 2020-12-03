extends Node

"""
Functions that help the player examine the whereabouts of their world.
"""
var mouseText = ""
var mouseObj = null

func _process(delta):
	var mouseCoords = get_viewport().get_mouse_position()

func onMouseEnter(object, objectName):
	
	# What if there's an overlap?
	if mouseObj != null:
		onMouseExit(mouseObj, mouseText)
	
	mouseText = "Examine " + objectName
	mouseObj = object
	
	# Highlight the object
	if mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 0.70
		
		
func onMouseExit(object, objectName):
	mouseText = ""
	
	# Unhighlight the object
	if mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 1.00
		
	mouseObj = null
