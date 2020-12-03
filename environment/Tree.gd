extends StaticBody

var mouseName = "Tree"

signal examineMouseEnter(object, objectName)
signal examineMouseExit()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Randomize the sprite
	var tree_types = $AnimatedSprite3D.frames.get_animation_names()
	$AnimatedSprite3D.animation = tree_types[randi() % tree_types.size()]
	
	if $AnimatedSprite3D.animation == "default":
		mouseName = "Oak Tree"
	elif $AnimatedSprite3D.animation == "pine":
		mouseName = "Smooth Pine Tree"
	elif $AnimatedSprite3D.animation == "pine_2":
		mouseName = "Pine Tree"
	else:
		mouseName = "WHAT"
		
	# Connect signals
	connect("examineMouseEnter", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseEnter")
	connect("examineMouseExit", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseExit")
	
func _on_Tree_mouse_entered():
	emit_signal("examineMouseEnter", self, mouseName)


func _on_Tree_mouse_exited():
	emit_signal("examineMouseExit")
