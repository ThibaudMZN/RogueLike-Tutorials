extends Node2D

@onready var player: Player = $Player
@onready var npc = $NPC

func _ready():
	var grid_size = (get_viewport().get_visible_rect().size / Constants.TILE_SIZE).floor()
	var player_position = GameMap.init(grid_size)
	player.init(player_position)
	npc.init(player_position - Vector2i(2, 0))

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
