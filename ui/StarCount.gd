extends RichTextLabel

# Keep track of our stars
var numPlayerStars = 0
var numLeft = 1

func _ready():
	# Get num of stars from WorldGeneration
	var root = get_node("../../")
	numLeft = root.numStars
	self.bbcode_text = "[right]Stars Left: " + str(numLeft) + "[/right]"

func onStarPickupText():
	numPlayerStars += 1
	numLeft -= 1
	self.bbcode_text = "[right]Stars / Left: " + str(numPlayerStars) + "/" + str(numLeft) + "[/right]"
	
	# Finish?
	if numLeft == 0:
		self.bbcode_text = "[right]You got them all![/right]"
		$RestartTimer.start()
		
func onStarPlace():
	numPlayerStars -= 1
	self.bbcode_text = "[right]Stars / Left: " + str(numPlayerStars) + "/" + str(numLeft) + "[/right]"
		
func _on_RestartTimer_timeout():
	get_tree().reload_current_scene()
