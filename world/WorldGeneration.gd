extends Spatial

var chunkId = 1
var scene = preload("res://world/Chunk.tscn")

# Used in genWorld(size) to determine where to spawn chunks for a particular iteration
enum GenDirec {LEFT = 0, DOWN = 1, RIGHT = 2, UP = 3}

func _ready():
	randomize()
	# Every 100 units, plop a new chunk
	# Place the ones surrounding the spawn chunk
	#createNewChunk(-100, 0)
	#createNewChunk(100, 0)
	
	#createNewChunk(-100, -100)
	#createNewChunk(0, -100)
	#createNewChunk(100, -100)
	
	# Old generation, keeping function just in case
	#genPath(30)
	
	# New generation, more spacious
	genWorld(5)
	
func genWorld(size):
	"""	
	We will generate in a circle, around the starting chunks.
	
	18	17	18	19	20
	9	8	7	6	19
	10	1	@	5	18
	11	2	3	4	17
	12	13	14	15	16
	
	In order to accomplish that, we will move in a certain direction x times, twice. 
	We go to the left once,
	Down once,
	
	Right twice,
	Up twice,
	
	Left thrice,
	Down thrice,
	
	Until we meet the size limit.
	
	"""
	
	# left 0, down 1, right 2, up 3
	var direction = 0
	var counter = 0
	var length = 1
	var didItOnce = false
	
	var currentZ = 0 # up - and down +
	var currentX = -100 # left - and right +
	
	while length <= size:
		
		createNewChunk(currentX, currentZ)
		counter += 1
		
		# Do we need to change directions?
		if counter == length:
			match direction:
				3:
					direction = 0
				_:
					direction += 1
			# Check with the boolean if we need to go this length again, albeit in another direction.
			if didItOnce:
				length += 1
				didItOnce = false
			else:
				didItOnce = true
			counter = 0
			
		# Determine new X and Z values
		match direction:
			0:
				currentX -= 100
			1:
				currentZ += 100
			2:
				currentX += 100
			3:
				currentZ -= 100
			
			
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
	var newChunk = scene.instance()
	
	# Set position
	var pos = Vector3(x, 0, z)
	newChunk.transform.origin = pos
	newChunk.setID(chunkId)
	chunkId += 1
	add_child(newChunk)
	
	# Populate with stuff
	newChunk.populate()
	
	# does nothing
	#newChunk.visible = false
