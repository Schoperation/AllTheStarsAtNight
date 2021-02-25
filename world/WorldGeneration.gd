extends Spatial

var nextChunkId = 1
var scene = preload("res://world/Chunk.tscn")
var chunkArray = []
var rng = RandomNumberGenerator.new()
export var numStars = 1

# Used in genWorld(size) to determine where to spawn chunks for a particular iteration
enum GenDirec {LEFT = 0, DOWN = 1, RIGHT = 2, UP = 3}

func _ready():
	# Randomize rngs
	randomize()
	rng.randomize()
	
	# Add origin chunk
	chunkArray.append($OriginChunk)
	
	# Gen
	genWorld(5)
	addStars(numStars)
	
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
	
	# Set ID and add to array
	newChunk.setID(nextChunkId)
	nextChunkId += 1
	add_child(newChunk)
	chunkArray.append(newChunk)
	
	# Populate with stuff
	newChunk.populate()
	
	# does nothing
	#newChunk.visible = false

func getChunkById(id) -> int:
	if id >= chunkArray.size():
		print("No such chunk with ID " + str(id))
		return -1
	else:
		return chunkArray[id]
		
func addStars(num):
	# Generate our list of possible IDs
	var possibleIds = []
	for i in range(chunkArray.size()):
		possibleIds.append(i)
	
	# Now, for the ids we'll spawn stars in
	var ids = []
	while ids.size() < num:
		var markedForDeletion = [] # We need to mark so we don't interrupt our j loop
		for j in range(possibleIds.size()):
			# Roll a die size of possibleIds.size, minus marked ones. If we get a 1, pick this number and remove it from possibleIds.
			if rng.randi_range(0, possibleIds.size() - markedForDeletion.size()) == 1 and ids.size() < num:
				ids.append(possibleIds[j])
				markedForDeletion.append(j)
		# Delete
		for k in range(markedForDeletion.size()):
			possibleIds.remove(markedForDeletion[k])
			
	print(ids)
	
	# Okay! Let's spawn them now.
	# Eventually they will fall out of the sky.
	# Grab the chunk, pick random coordinates, and whammo
	var starObj = load("res://environment/Star.tscn")
	for j in range(ids.size()):
		var chunk = getChunkById(ids[j])
		#var x = rand_range(chunk.transform.origin.x - 50, chunk.transform.origin.x + 50)
		#var z = rand_range(chunk.transform.origin.z - 50, chunk.transform.origin.z + 50)
		var x = rand_range(-10, 10) # in relation to the chunk
		var z = rand_range(-10, 10)
		
		var newStar = starObj.instance()
		chunk.add_child(newStar)
		var pos = Vector3(x, 2.7, z)
		newStar.transform.origin = pos
		
		
		
