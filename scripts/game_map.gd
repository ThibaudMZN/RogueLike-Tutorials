extends TileMap

var size: Vector2i = Vector2.ZERO

func init(init_size: Vector2i):
	size = init_size
	for x in range(size.x):
		for y in range(size.y):
			var coords = Vector2i(x, y)
			set_cell(0, coords, 0, Constants.FLOOR_TILE)
			
	set_cell(0, Vector2(15, 11), 0, Constants.WALL_TILE)
	set_cell(0, Vector2(16, 11), 0, Constants.WALL_TILE)

func in_bounds(pos: Vector2i) -> bool:
	return 0 <= pos.x and pos.x < size.x and 0 <= pos.y and pos.y < size.y

func is_tile_walkable(pos: Vector2i) -> bool:
	var data = get_cell_tile_data(0, pos)
	if data:
		return data.get_custom_data("walkable")
	else:
		return false
