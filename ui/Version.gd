extends RichTextLabel

# Version
var gameName = "All the Stars at Night"
var desc = "Explore an in-depth forest with an in-depth duo"
var version = "0.3.0 pre"

func _ready():
	# Change version
	self.text = gameName + " v" + version
	
func _process(delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
