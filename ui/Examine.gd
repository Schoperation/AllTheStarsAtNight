extends Label

"""
Functions that help the player examine the whereabouts of their world.
"""
var mouseObj = null
var mouseObjName = ""
var playerThought

var quotes = {
	"Oak Tree": "Pretty normal tree.",
	"Pine Tree": "Even more normal than the oak tree.",
	"Another Pine Tree": "Looks like a Xmas tree.",
	"Rock": "What are you looking at?",
	"Star": "Very shiny. I wonder if I can pick it up?",
	"Empty Star Stone": "That's a weirdly empty stone. Maybe something goes here?",
	"Place Star": "Let's see what happens...",
	"Activated Star Stone": "I feel a weird energy eminating from this... thing."
}

func _ready():
	playerThought = get_parent().get_parent().get_node("PlayerThought")

func _process(delta):
	# Set text to mousecoords
	var mouseCoords = get_viewport().get_mouse_position()
	get_parent().set_position(mouseCoords)
	
func _input(event):
	# Click?
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouseObjName != "":
		playerThought.text = quotes[mouseObjName]
		playerThought.get_node("DisplayTimer").start()
		
func onMouseEnter(object, objectName):
	
	# What if there's an overlap?
	if mouseObj != null:
		onMouseExit()
	
	if objectName == "Place Star":
		text = objectName
	else:
		text = "Examine " + objectName
	mouseObj = object
	mouseObjName = objectName
	
	# Highlight the object
	if mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 0.70
		
		
func onMouseExit():
	text = ""
	mouseObjName = ""
	
	# Unhighlight the object
	if mouseObj != null and mouseObj.has_node("AnimatedSprite3D"):
		mouseObj.get_node("AnimatedSprite3D").opacity = 1.00
		
	mouseObj = null

# Hide the examine text
func _on_DisplayTimer_timeout():
	playerThought.text = ""
