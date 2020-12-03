extends StaticBody

const Examine = preload("res://environment/Examine.gd")
var examine = Examine.new()
var mouseName = "Tree"

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
	
func _on_Tree_mouse_entered():
	examine.onMouseEnter(self, mouseName)


func _on_Tree_mouse_exited():
	examine.onMouseExit(self, mouseName)
