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
	self.bbcode_text = "[right]Stars Left: " + str(numStars) + "[/right]"

func onStarPickupText():
	numLeft -= 1
	self.bbcode_text = "[right]Stars Left: " + str(numLeft) + "[/right]"
	
	# Finish?
	if numLeft == 0:
		self.bbcode_text = "[right]You got them all![/right]"
		$RestartTimer.start()
		
func _on_RestartTimer_timeout():
	get_tree().reload_current_scene()
