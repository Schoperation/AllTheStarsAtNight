extends StaticBody

var id = 0
var treeScene = preload("res://environment/Tree.tscn")
var trailChunk = false

# ID handling... spawn chunk is id 0
func setID(id):
	self.id = id
	
func getID() -> int:
	return self.id
	
func _ready():
	if transform.origin.x == 0 and transform.origin.z > 0:
		trailChunk = true
	
# Populates the chunk with objects like trees
func populate():
	plantTrees(not trailChunk)
	
	if trailChunk:
		addTrail()
	#todo add more like trails, rocks, and then... random structures woooahhh
		
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
	var TRAIL_SIZE = rand_range(5, 8)
	
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
		
func addTrail():
	pass
