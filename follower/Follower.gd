extends StaticBody

"""
Code for Barfite and Vigil wooooo
"""

export var isBarfite = true
var player
var otherFollower

func _ready():
	player = get_parent().get_node("Player")
	otherFollower = get_parent().get_node("Vigil") if isBarfite else get_parent().get_node("Barfite")
	
	# Add to followers group
	add_to_group("Followers")
	
	# Determine pitch
	if isBarfite:
		$Voice.pitch_scale = 1.39
	else:
		$Voice.pitch_scale = 1.7

func _process(delta):
	pathfind()
	
# Travel to the player... so far just straight lines	
func pathfind():
	
	# Let Barfite travel to the player and Vigil follow Barfite
	if isBarfite:
		var distanceZ = player.transform.origin.z - self.transform.origin.z
		var distanceX = player.transform.origin.x - self.transform.origin.x
		var travelZ = distanceZ / 50
		var travelX = distanceX / 50
		
		if abs(distanceX) > 3:
			translate(Vector3(travelX, 0, 0))
		if abs(distanceZ) > 3:
			translate(Vector3(0, 0, travelZ))
	else:
		var distance2Z = otherFollower.transform.origin.z - self.transform.origin.z
		var distance2X = otherFollower.transform.origin.x - self.transform.origin.x
		#var distance2 = self.transform.origin.distance_to(otherFollower.transform.origin)
		var travel2Z = distance2Z / 30
		var travel2X = distance2X / 30
		
		if abs(distance2X) > 3:
			translate(Vector3(travel2X, 0, 0))
		if abs(distance2Z) > 3:
			translate(Vector3(0, 0, travel2Z)) 
	
