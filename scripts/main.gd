extends Node2D

@onready var player: Player = $Player
@onready var npc = $NPC

func _ready():
	var grid_size = (get_viewport().get_visible_rect().size / Constants.TILE_SIZE).floor()
	var grid_center = (grid_size / 2).floor() as Vector2i
	player.init(grid_center)
	npc.init(grid_center + Vector2i(2, 0))
	GameMap.init(grid_size)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
