extends Spatial

"""
How the game will start and end...
"""

var stoneScene = preload("res://ring/StarStone.tscn")

var numPlayerStars = 0 # Stars the player has on their person
var numStonesActivated = 0 # Stars on stones
var numStones = 10 # Total stones
export var radius = 40

func _ready():
	# How many stones do we need? Ask the root node
	numStones = get_node("../../").numStars
	
	# Spawn stones in a circle around the center
	var position = Vector3(radius, 0, 0)
	var polarAngle = 0
	for i in range(numStones):
		var stone = stoneScene.instance()
		stone.transform.origin = position
		add_child(stone)
		
		# Create new position
		polarAngle += (2 * PI) / numStones
		position = Vector3(radius * cos(polarAngle), 0, radius * sin(polarAngle))

# When a star is added to one of its stones
func addStarToRing():
	numStonesActivated += 1
	numPlayerStars -= 1
	
	# Do we have them all????
	if numStonesActivated == numStones:
		get_tree().reload_current_scene()
		
# When a player picks up a star, called from a star instance
func onStarPickup():
	numPlayerStars += 1
