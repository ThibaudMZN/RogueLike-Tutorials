extends Node2D

@onready var player: Player = $Player

func _ready():
	var window_size = get_viewport().get_visible_rect().size
	player.init_player(Vector2(round(window_size.x / 2), round(window_size.y / 2)))

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
