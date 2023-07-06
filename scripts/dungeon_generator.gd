class_name DungeonGenerator

enum TUNNEL_ORIENTATION { HORIZONTAL, VERTICAL }

class Tunnel:
	var start: Vector2i
	var corner: Vector2i
	var end: Vector2i
	var orientation: TUNNEL_ORIENTATION
	
	func bresenham_line(p0: Vector2i, p1: Vector2i) -> Array[Vector2i]:
		assert(p0.x ==  p1.x or p0.y == p1.y)
		var points: Array[Vector2i] = []
		var dx = abs(p1.x - p0.x)
		var dy = -abs(p1.y - p0.y)
		var err = dx + dy
		var e2 = 2 * err
		var sx = 1 if p0.x < p1.x else -1
		var sy = 1 if p0.y < p1.y else -1
		while true:
			points.append(p0)
			if p0 == p1:
				break
			e2 = 2 * err
			if e2 >= dy:
				err += dy
				p0.x += sx
			if e2 <= dx:
				err += dx
				p0.y += sy
		return points
	
	func _init(p0: Vector2i, p1: Vector2i, p2: Vector2i, first_orientation: TUNNEL_ORIENTATION):
		start = p0
		corner = p1
		end = p2
		orientation = first_orientation
		
	var inner: Array:
		get:
			var pts: Array[Vector2i] = []
			var first_offsets = [Vector2i(0, 1), Vector2i(0, -1)] \
				if orientation == TUNNEL_ORIENTATION.HORIZONTAL \
				else [Vector2i(1, 0), Vector2i(-1, 0)]
			var second_offsets = [Vector2i(0, 1), Vector2i(0, -1)] \
				if orientation == TUNNEL_ORIENTATION.VERTICAL \
				else [Vector2i(1, 0), Vector2i(-1, 0)]
			for pt in bresenham_line(start, corner):
				pts.append(pt)
				pts.append(pt + first_offsets[0])
				pts.append(pt + first_offsets[1])
			for pt in bresenham_line(corner, end):
				pts.append(pt)
				pts.append(pt + second_offsets[0])
				pts.append(pt + second_offsets[1])
#			for x in range(start.x, end.x):
#				for y in range(start.y, end.y):
#					indices.append(Vector2i(x, y))
			return pts


class RectangularRoom:
	var start: Vector2i
	var end: Vector2i
	
	var center: Vector2i:
		get:
			return start + (end - start) / 2
			
	var inner: Array[Vector2i]:
		get:
			var indices: Array[Vector2i] = []
			for x in range(start.x, end.x):
				for y in range(start.y, end.y):
					indices.append(Vector2i(x, y))
			return indices

	func _init(top_left: Vector2i, size: Vector2i):
		start = top_left
		end = top_left + size

	func intersects(other: RectangularRoom) -> bool:
		return start.x <= other.end.x and end.x >= other.start.x and start.y <= other.end.y and end.y >= other.start.y

func generate_dungeon(size: Vector2i, max_room: int, room_min_max_size: Vector2i):
	var rooms: Array[RectangularRoom] = []
	var tunnels = []
	
	for r in range(max_room):
		var w = RngManager.rng.randi_range(room_min_max_size.x, room_min_max_size.y)
		var h = RngManager.rng.randi_range(room_min_max_size.x, room_min_max_size.y)
		var x = RngManager.rng.randi_range(0, size.x - w - 1)
		var y = RngManager.rng.randi_range(0, size.y - h - 1)
		var new_room = RectangularRoom.new(Vector2i(x,y), Vector2i(w,h))
		if rooms.filter(func(room): return room.intersects(new_room)).size() == 0:
			rooms.append(new_room)
		if rooms.size() > 1:
			var last_index = rooms.size() - 1
			var tunnel = tunnel_between(rooms[last_index].center, rooms[last_index - 1].center)
			tunnels.append(tunnel)
	return {
		"rooms": rooms,
		"tunnels": tunnels
	}
	
func tunnel_between(start: Vector2i, end: Vector2i) -> Tunnel:
	var corner = Vector2i(end.x, start.y)
	var orientation = TUNNEL_ORIENTATION.HORIZONTAL
	if RngManager.rng.randf() > 0.5:
		corner = Vector2i(start.x, end.y)
		orientation = TUNNEL_ORIENTATION.VERTICAL
	
	var tunnel: Tunnel = Tunnel.new(start, corner, end, orientation)
#	var tunnel: Array[Vector2i] = bresenham_line(start, corner)
#	tunnel.append_array(bresenham_line(corner, end))
	return tunnel
	
