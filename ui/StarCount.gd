extends RichTextLabel

# Keep track of our stars
var numStars = 0
var numLeft = 1

signal onStarPickup()

func _ready():
	# Get num of stars from WorldGeneration
	var root = get_node("../../")
	numStars = root.numStars
	numLeft = numStars
	self.text = "Stars Left: " + str(numStars)

func onStarPickupText():
	numLeft -= 1
	self.text = "Stars Left: " + str(numLeft)
	
	# Finish?
	if numLeft == 0:
		self.text = "You got them all!"
		$RestartTimer.start()
		
func _on_RestartTimer_timeout():
	get_tree().reload_current_scene()
