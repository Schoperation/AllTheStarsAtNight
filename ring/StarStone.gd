extends StaticBody

signal examineMouseEnter(object, objectName)
signal examineMouseExit()

var hasStar = false
var lightEnergy = 0
var lightIncrease = 0.05

var currentY = 1.45
var sineTime = 0

func _ready():
	# Connect signals
	connect("examineMouseEnter", get_node("../../../UI/MouseTextContainer/MouseText"), "onMouseEnter")
	connect("examineMouseExit", get_node("../../../UI/MouseTextContainer/MouseText"), "onMouseExit")
	
	# Add to environment objects group
	add_to_group("Environment_Objs")
	
	# Set light energy
	$OmniLight.light_energy = lightEnergy
	
	# Set custom star settings
	if not hasStar:
		$Star.visible = false
		$AnimatedSprite3D.animation = "idle"
		
	$Star/OmniLight.light_energy = 1

# Used to emit a pulse of light, and move a star above it!
func _process(delta):
	if hasStar:
		# Light
		lightEnergy += lightIncrease
		if lightEnergy >= 2 or lightEnergy <= 0:
			lightIncrease *= -1
			
		$OmniLight.light_energy = lightEnergy
		
		# Star
		# Move y based on a sine curve
		currentY = 0.3 * sin(sineTime * PI/180) + 1.5
		sineTime += 1
		
		# Reset sineTime so we don't get an integer overflow
		if sineTime > 360:
			sineTime = 0
			
		$Star.transform.origin = Vector3($Star.transform.origin.x, currentY, $Star.transform.origin.z)

func placeStar():
	# Notify parent ring
	get_parent().addStarToRing()
	
	hasStar = true
	$AnimatedSprite3D.animation = "activated"
	$Star.visible = true
	
func _on_StarStone_mouse_entered():
	if hasStar:
		emit_signal("examineMouseEnter", self, "Activated Star Stone")
	elif get_parent().numPlayerStars > 0:
		emit_signal("examineMouseEnter", self, "Place Star")
	else:
		emit_signal("examineMouseEnter", self, "Empty Star Stone")
		
func _on_StarStone_mouse_exited():
	emit_signal("examineMouseExit")
	
# Detect clicks
func _on_StarStone_input_event(camera, event, click_position, click_normal, shape_idx):
	#if event is InputEventMouseButton:
	if event.is_action_pressed("add_star") and not hasStar and get_parent().numPlayerStars > 0:
		placeStar()
		emit_signal("examineMouseExit")
		emit_signal("examineMouseEnter", self, "Activated Star Stone")
