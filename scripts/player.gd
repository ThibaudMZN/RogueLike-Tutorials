extends Node2D
class_name Player

func _ready():
	pass

func _process(delta):
	var d_pos = Input.get_vector("left", "right", "up", "down")		
	position += d_pos.floor()

func init_player(pos: Vector2):
	position = pos
