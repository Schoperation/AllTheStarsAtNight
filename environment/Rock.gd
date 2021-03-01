extends StaticBody

signal examineMouseEnter(object, objectName)
signal examineMouseExit()

func _ready():
	# Connect signals
	connect("examineMouseEnter", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseEnter")
	connect("examineMouseExit", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseExit")
	
	# Add to environment objects group
	add_to_group("Environment_Objs")


func _on_Rock_mouse_entered():
	emit_signal("examineMouseEnter", self, "Rock")


func _on_Rock_mouse_exited():
	emit_signal("examineMouseExit")
