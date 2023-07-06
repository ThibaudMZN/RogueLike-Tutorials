extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = 42
