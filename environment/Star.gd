extends RigidBody

signal examineMouseEnter(object, objectName)
signal examineMouseExit()

func _ready():
	# Connect signals
	connect("examineMouseEnter", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseEnter")
	connect("examineMouseExit", get_node("../../UI/MouseTextContainer/MouseText"), "onMouseExit")
	

func _on_Star_mouse_entered():
	emit_signal("examineMouseEnter", self, "Star")


func _on_Star_mouse_exited():
	emit_signal("examineMouseExit")


func _on_Star_body_entered(body):
	print("Hello there")
