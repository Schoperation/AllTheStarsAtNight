extends RichTextLabel

# Version
var gameName = "All the Stars at Night"
var desc = "Explore an in-depth forest with an in-depth duo"
var version = "1.0.0 pre"

var isShown = false

func _ready():
	# Change version
	self.text = gameName + " v" + version + " [V to toggle]"
	
func _input(event):
	if Input.is_action_just_pressed("show_version"):
		isShown = not isShown
		self.visible = not self.visible
	
func _process(delta):
	if isShown:
		$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
