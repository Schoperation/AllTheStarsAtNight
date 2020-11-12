extends DirectionalLight
export var dayNightCycleEnabled = true

func _process(delta):
	if dayNightCycleEnabled:
		testDayNightCycle()
	
func testDayNightCycle():
	transform.basis = transform.basis.rotated(Vector3(0, 0, 1), 0.001)
	transform.basis = transform.basis.rotated(Vector3(0, 1, 0), -0.001)
