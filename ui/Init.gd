extends Control

"""
Handles initialization and button presses on the main menu.
"""

func _init():
	# Start ambience
	pass

# Starts the game
func _on_PlayButton_pressed():
	# Get rid of menus
	self.visible = false
	
	# Unpause
	get_tree().paused = false
	
	# Activate dialogues
	get_node("../DialogueBox").startDialogue("intro")


func _on_CreditsButton_pressed():
	$PlayButton.visible = false
	$CreditsButton.visible = false
	
	$Credits.visible = true
	$BackButton.visible = true


func _on_BackButton_pressed():
	$PlayButton.visible = true
	$CreditsButton.visible = true
	
	$Credits.visible = false
	$BackButton.visible = false

