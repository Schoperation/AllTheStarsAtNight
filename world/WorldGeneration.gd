extends Spatial

var chunkId = 1

func _ready():
	randomize()
	# Every 100 units, plop a new chunk
	# Place the ones surrounding the spawn chunk
	createNewChunk(-100, 0)
	createNewChunk(100, 0)
	
	createNewChunk(-100, -100)
	createNewChunk(0, -100)
	createNewChunk(100, -100)
	
	createNewChunk(0, 100)
	
func createNewChunk(x, z):
	var scene = load("res://world/Chunk.tscn")
	var newChunk = scene.instance()
	
	# Set position
	var pos = Vector3(x, 0, z)
	newChunk.transform.origin = pos
	newChunk.setID(chunkId)
	chunkId += 1
	add_child(newChunk)
	
	# Populate with stuff (trees for now)
	newChunk.populate()
