extends Node2D
class_name Entity

@export var grid_position: Vector2i = Vector2i.ZERO:
	set(value):
		grid_position = value
		position = grid_position * Constants.TILE_SIZE + Constants.HALF_TILE_SIZE

func init(grid_pos: Vector2i):
	grid_position = grid_pos

func move(d_pos: Vector2i):
	var new_pos = grid_position + d_pos
	if GameMap.is_tile_walkable(new_pos):
		grid_position += d_pos
