extends Label

"""
Deals with the dialogue
"""

# Array of text files
var textFiles = [
	"boat",
	"boyscouts",
	"fatigue",
	"life",
	"mosquitoes"
]

var currentSpeaker

# Increment
var increment = 0.00

# Should we make them talk?
func _on_NewDialogueTimer_timeout():
	# Every number of seconds, random chance for them to start yapping, if not already.
	var die = round(rand_range(0, 7))
	if die == 2:
		$NewDialogueTimer.stop()
		
		# Alright, let's pick a random text file to load and parse. Remove it from the list for no repeats.
		if not textFiles.empty():
			var textFile = textFiles[floor(rand_range(0, textFiles.size()))]
			textFiles.remove(textFiles.find(textFile))
			startDialogue(textFile)
	else:
		#print("Nope...")
		pass

# Start a dialogue, any dialogue
func startDialogue(textFile):
	# Load file
	var file = File.new()
	var path = "res://dialogue/" + textFile + ".txt"
	
	if file.file_exists(path):
		file.open(path, File.READ)
	else:
		print("Couldn't open the file at path " + path)
		
	# Now, let's parse each line
	while not file.eof_reached():
		var line = file.get_line()
		
		# First part indicates Barfite or Vigil
		var speaker = line.substr(0, 1)
		if speaker == "B":
			currentSpeaker = get_node("../../Barfite/Voice")
		else:
			currentSpeaker = get_node("../../Vigil/Voice")
			
		# Extract actual dialogue
		if line != "":
			yield(displayDialogue(line.substr(3)), "completed")
			
	file.close()
	self.text = ""
	$NewDialogueTimer.start()

# Read the string and output it into the text box
func displayDialogue(dialogue):
	# Reset percent visible and textbox
	self.percent_visible = 0.0
	self.text = dialogue
	
	# Figure out how much ot increment percent_visible, depending on length
	self.increment = 1.00 / dialogue.length()
	
	# Now do it, on a timer
	$NextCharTimer.start()
	currentSpeaker.playing = true
	
	# Use our own stupid little timer because godot is dumb with waiting and such and dumb yields oooOOooOoo
	$DispDiaTimer.set_wait_time(dialogue.length() * $NextCharTimer.wait_time + 0.2)
	$DispDiaTimer.start()
	yield($DispDiaTimer, "timeout")
	
	# Pause before showing the next line
	$NextCharTimer.stop()
	$NextLineTimer.start()
	currentSpeaker.playing = false
	
	yield($NextLineTimer, "timeout")
	pass

# Our little timer loop... reveals the next char in our dialogue
func _on_NextCharTimer_timeout():
	self.percent_visible += self.increment

# Just a little extra time to read the dialogue.
func _on_NextLineTimer_timeout():
	pass
