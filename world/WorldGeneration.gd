extends Spatial

var chunkId = 1
var scene = preload("res://world/Chunk.tscn")

func _ready():
	randomize()
	# Every 100 units, plop a new chunk
	# Place the ones surrounding the spawn chunk
	createNewChunk(-100, 0)
	createNewChunk(100, 0)
	
	createNewChunk(-100, -100)
	createNewChunk(0, -100)
	createNewChunk(100, -100)
	
	genPath(30)
	
func genPath(length):
	# $ $ $
	# $ @ $
	# ! | !
	
	# $ and @ are starting chunks, with the @ being spawn chunk. Those are pregenerated in _ready().
	# ! and | are the chunks that have the actual path. ! are full of trees while the | has the trail. | can vary.
	# Every 100 units, make a new set of chunks.
	var currentZ = 100
	for n in range(length):
		createNewChunk(-100, currentZ)
		createNewChunk(0, currentZ)
		createNewChunk(100, currentZ)
		currentZ += 100
		
	# Move the GameEnd field
	$GameEnd.translate(Vector3(0, 0, currentZ - 100))
	
func createNewChunk(x, z):
	#var scene = load("res://world/Chunk.tscn")
	var newChunk = scene.instance()
	
	# Set position
	var pos = Vector3(x, 0, z)
	newChunk.transform.origin = pos
	newChunk.setID(chunkId)
	chunkId += 1
	add_child(newChunk)
	
	# Populate with stuff
	newChunk.populate()
