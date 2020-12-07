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
	
	var distanceZ = player.transform.origin.z - self.transform.origin.z
	var distanceX = player.transform.origin.x - self.transform.origin.x
	var distance = self.transform.origin.distance_to(player.transform.origin)
	var travelZ = distanceZ / 50
	var travelX = distanceX / 50
	
	if abs(distanceX) > 3:
		translate(Vector3(travelX, 0, 0))
	if abs(distanceZ) > 3:
		translate(Vector3(0, 0, travelZ))
