## basic grid 
##
## description here 
##

class_name Grid2D 

## creates and returns a 2d array of dimensions len_x by len_y [br]
## fills each grid location with default_val 
static func create_new(len_x : int, len_y : int, default_val = 0) -> Array : ## returns a new 2d array
	var grid = []
	for x in range(len_x):
		grid.append([])
		for y in range(len_y):
			grid[x].append(default_val)
	
	print_debug("created grid ", grid)
	return grid

static func print_grid(grid : Array, padding : int = 3 ):
	for y in grid[0].size():
		var row := ""
		for x in range(grid.size()):
			row += "%*s" % [padding, grid[x][y]]
		print(row)
