extends StaticBody

"""
Code for Barfite and Vigil wooooo
"""

export var isBarfite = true
var player

func _ready():
	player = get_parent().get_node("Player")

func _process(delta):
	pathfind()
	
# Travel to the player... so far just straight lines	
func pathfind():
	
	var distance = self.transform.origin.distance_to(player.transform.origin)
