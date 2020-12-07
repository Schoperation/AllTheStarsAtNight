extends DirectionalLight
export var dayNightCycleEnabled = true

var isDay = true
var hourTick = 12
var minuteTick = 0
var tick = 0

func addTick():
	minuteTick += 1
	if minuteTick > 59:
		hourTick += 1
		minuteTick = 0
	if hourTick > 23:
		hourTick = 0
		
func addTick2():
	tick += 1

func _process(delta):
	if dayNightCycleEnabled:
		testDayNightCycle()
	
func testDayNightCycle():
	transform.basis = transform.basis.rotated(Vector3(0, 0, 1), 0.001)
	transform.basis = transform.basis.rotated(Vector3(0, 1, 0), -0.001)


func _on_DayCycle_timeout():
	pass
	#print(rotation_degrees.z)
	#print(str(hourTick) + ":" + str(minuteTick))
