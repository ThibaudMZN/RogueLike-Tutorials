extends Entity
class_name Player

func _input(event):
	var d_pos = Vector2i.ZERO
	if event.is_action_pressed("left"):
		d_pos.x -= 1
	elif event.is_action_pressed("right"):
		d_pos.x += 1
	elif event.is_action_pressed("up"):
		d_pos.y -= 1
	elif event.is_action_pressed("down"):
		d_pos.y += 1
	move(d_pos)
