extends StaticBody

var mouseName = "Tree"

signal examineMouseEnter(object, objectName)
signal examineMouseExit(object, objectName)

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
	#connect("examineMouseEnter", get_tree().get_.get_node())
	
func _on_Tree_mouse_entered():
	emit_signal("../../UI/MouseTextContainer/MouseText/examineMouseEnter", self, mouseName)
	#examine.onMouseEnter(self, mouseName)


func _on_Tree_mouse_exited():
	emit_signal("../../UI/MouseTextContainer/MouseText/examineMouseExit", self, mouseName)
	#examine.onMouseExit(self, mouseName)
