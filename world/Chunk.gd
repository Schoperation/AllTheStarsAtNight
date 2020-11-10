extends StaticBody

var id = 0
var treeScene = preload("res://environment/Tree.tscn")
var trailScene = preload("res://environment/Trail.tscn")
var trailChunk = false
var structureChunk = false

# ID handling... spawn chunk is id 0
func setID(id):
	self.id = id
	
func getID() -> int:
	return self.id
	
func _ready():
	if transform.origin.x == 0 and transform.origin.z > 0:
		trailChunk = true
		
	# Determine if we should spawn a structure here
	var die = round(rand_range(0, 10))
	if die == 7 and trailChunk:
		structureChunk = true
	
# Populates the chunk with objects like trees
func populate():
	if not structureChunk:
		plantTrees(not trailChunk)
	
	if trailChunk:
		addTrail()
	#todo add more like trails, rocks, and then... random structures woooahhh
	if structureChunk:
		addStruct()
		print(id)
		
# Plants trees on the chunk
func plantTrees(thick):
	# We'll create a random grid of rows and cols, thus having row*col trees.
	# Plant a tree in each cell, then apply a random offset to each tree so it isn't a neat grid of trees
	# ...unless this was planted by the US Forest Service... 
	var numRows = 0
	var numCols = 0
	var OFFSET = 6
	numRows = round(rand_range(4, 9))
	numCols = round(rand_range(4, 9))
	
	# Generate a bunch of coordinates. The chunk is 100x100 units, and the origin is local to the middle of the chunk.
	# Thus we can plant a tree from -50 to 50, in relation to the chunk.
	var coords = []
	var currentX = -50
	var currentZ = -50
	var TRAIL_SIZE = rand_range(12, 16)
	
	for i in range(numRows):
		for j in range(numCols):
			currentZ += (100 / numCols)
			# Leave room in the middle for a trail, if applicable
			if not thick and (currentX < (-1 * TRAIL_SIZE) or currentX > TRAIL_SIZE):
				coords.append([currentX, currentZ])
			elif thick:
				coords.append([currentX, currentZ])
		currentX += (100 / numRows)
		currentZ = -50
	
	# Now apply a random offset to each coordinate pair
	for coord in coords:
		coord[0] += rand_range(-1 * OFFSET, OFFSET)
		coord[1] += rand_range(-1 * OFFSET, OFFSET)
		
		coord[0] = clamp(coord[0], -50, 50)
		coord[1] = clamp(coord[1], -50, 50)
	
	# Plant trees
	for n in range(coords.size()):
		var tree = treeScene.instance()
		tree.translate(Vector3(coords[n][0], 1, coords[n][1]))
		add_child(tree)
		
# Add a trail, if applicable
func addTrail():
	# Unlike the trees, we can just directly plop down a trail without creating a 2d array of coords.
	var currentX = -0.3
	var currentZ = -1
	for i in range(10):
		var amount = round(rand_range(3, 5))
		for j in range(amount):
			var trailPiece = trailScene.instance()
			trailPiece.translate(Vector3(currentX, 1, currentZ))
			trailPiece.scale = Vector3(0.1, 1, 0.1)
			
			# Random rotation
			var rotation = round(rand_range(1, 4))
			trailPiece.rotate_y(rotation * (PI/2))
			
			add_child(trailPiece)
			currentX += 0.2
		amount = round(rand_range(3, 5))
		currentZ += 0.2
		currentX = rand_range(-0.4, -0.1)
		
# Generates structures
func addStruct():
	
	# Choose a structure
	var pick = round(rand_range(1, 1))
	pass
