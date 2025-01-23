# CURRENT: sort out proximity allocations 

extends Node2D

const MINE_ID : int = -1 ## numerical ID representing mines in data grid

var w : int 
var h : int
var n : int 

# 2d array representing game board
var grid : Array 
# coordinates of mines 
var mine_locations : Array
@export var tile_scene : PackedScene 
@export var mine_tile_texture : Texture2D
@export var number_tile_png : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	# get configuration info from settings singleton
	self.w = Settings.grid_width
	self.h = Settings.grid_height
	self.n = Settings.n_mines
	
	setup_board_data()
	setup_board_ui()

func setup_board_data():
	
	self.grid = Grid2D.create_new(w, h)
	self.mine_locations = []
	
	# placing mines until we have requested n
	while mine_locations.size() != n:
		var x : int 
		var y : int
		
		var is_mined := false 
		while not is_mined:
			x = randi_range(0, self.w - 1)
			y = randi_range(0, self.h - 1)
			if not mine_locations.has([x,y]):
				self.grid[x][y] = MINE_ID
				mine_locations.append([x,y])
				is_mined = true

	#print_debug(self.grid)
	print("Mines laid: ")
	Grid2D.print_grid(grid)
	
	# list of positional vectors for all 8 neighbouring grid squares
	var neighbours = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN, Vector2i.UP + Vector2i.RIGHT, Vector2i.DOWN + Vector2i.RIGHT, Vector2i.LEFT + Vector2i.DOWN, Vector2i.LEFT + Vector2i.UP]
	
	# assign mine proximity scores to all non-mined locations
	for x in range(self.w):
		for y in range(self.h):
			
			# if tile is a mine don't evaluate neighbours  
			if grid[x][y] == MINE_ID:
				continue # skip iteration
				
			var n_mined_neighbours := 0
			for pos in neighbours:
				var x_pos = x + pos.x
				var y_pos = y + pos.y
				
				# if neighbour outside of grid then skip 
				if x_pos < 0 or x_pos >= self.w or y_pos < 0 or y_pos >= self.h:
					continue
				
				elif grid[x_pos][y_pos] == MINE_ID:
					n_mined_neighbours += 1
				
			grid[x][y] = n_mined_neighbours
			
			
	#print_debug(self.grid)
	print("Proximities assigned: ")
	Grid2D.print_grid(grid)

func setup_board_ui():
	
	
	for x in range(w):
		for y in range(h):
			var tile : Tile = tile_scene.instantiate()
			tile.position = Vector2(x, y) * tile.get_sprite_dim()
			add_child(tile)
			# may need to reparent tiles on instantiation to a board node for easy positioning e.g.:
			#tile.reparent(some_parent_node)
			var tile_value = grid[x][y]
			if tile_value == 0:
				continue
			elif tile_value == -1:
				tile.set_revealed_texture(mine_tile_texture)
				#print_debug("TODO: assign bomb tiles with mine sprite")
				pass
			else: # tile is not empty or bomb
				tile.set_revealed_texture(number_tile_png[tile_value-1])
			
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
