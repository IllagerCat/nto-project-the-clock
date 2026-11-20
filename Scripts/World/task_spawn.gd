extends Node

@export var taskScene: PackedScene
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = self.get_parent().get_node('Player')
var positions := [Vector2(-300.0, -500.0), Vector2(0.0, -500.0), Vector2(300.0, -500.0), \
Vector2(-300.0, 0.0), Vector2(0.0, 0.0), Vector2(300.0, 0.0)]
var weights := [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
var isTaskHere := [false, false, false, false, false, false]

func _ready():
	timer.timeout.connect(_task_spawn)

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if SignalBus.pause:
		timer.paused = true
	elif timer.paused:
		timer.paused = false

func _task_spawn():
	is_player_near()
	if 1.0 in weights:
		for repeat in range(RandomNumberGenerator.new().rand_weighted([2.0, 1.0]) + 1):
			var task = taskScene.instantiate()
			var index = RandomNumberGenerator.new().rand_weighted(weights)
			task.global_position = positions[index]
			self.get_parent().get_node('Tasks').add_child(task)
			isTaskHere[index] = true
			weights[index] = 0.0

func is_player_near():
	for index in range(6):
		if positions[index].y == int(player.global_position.y):
			if abs(positions[index].x - int(player.global_position.x)) <= 150.0:
				weights[index] = 0.0
				continue
		weights[index] = 1.0 if not isTaskHere[index] else 0.0
