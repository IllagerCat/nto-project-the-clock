extends Camera2D

var player: CharacterBody2D

func _ready():
	player = get_parent().get_node("Player")

func _process(_delta: float):
	global_position.y = player.global_position.y - 80.0
