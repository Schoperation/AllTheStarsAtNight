extends RigidBody

export var isPartOfStone = false
signal examineMouseEnter(object, objectName)
signal examineMouseExit()
signal onStarPickup()

func _ready():
	# Connect signals, if not part of a star stone, which is set via editor
	if not isPartOfStone:
		connect("examineMouseEnter", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseEnter")
		connect("examineMouseExit", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseExit")
		connect("onStarPickup", get_node("../../OriginChunk/StarRing"), "onStarPickup")
	
	# Add to environment objects group
	add_to_group("Environment_Objs")

func _on_Star_mouse_entered():
	emit_signal("examineMouseEnter", self, "Star")


func _on_Star_mouse_exited():
	emit_signal("examineMouseExit")


func _on_Star_body_entered(body):
	if body.name == "Player":
		emit_signal("onStarPickup")
		emit_signal("examineMouseExit")
		queue_free()

