extends CharacterBody2D

var SPEED := 300.0
var direction := Vector2(0, 0)
var targets := []

func _ready():
	#Слушаем шину
	SignalBus.task_clicked.connect(_on_task_clicked)

func _physics_process(delta: float):
	if targets:
		if (int(global_position.x) == int(targets[0].x) and int(global_position.y) == int(targets[0].y)):
			targets.pop_front()
		if targets:
			direction = _define_direction(targets[0])
		else:
			direction = Vector2(0, 0)
	velocity = direction * SPEED
	move_and_slide()

func _on_task_clicked(coords: Vector2, isLadder: bool):
	if isLadder:
		targets = [Vector2(coords.x, int(global_position.y)), \
		Vector2(coords.x, 0.0 if int(global_position.y) == -500 else -500.0)]
		if coords.x == int(global_position.x):
			targets = [Vector2(int(global_position.x), 0.0 if int(global_position.y) <= coords.y else -500.0)]
		elif coords.x == -int(global_position.x):
			targets[0] = Vector2(global_position.x, \
			0.0 if int(global_position.y) >= coords.y and int(global_position.y) != 0 \
			or int(global_position.y) == 0 else -500)
			targets[1] = Vector2(coords.x, targets[0].y)
			targets.append(Vector2(coords.x, 0.0 if targets[1].y == -500.0 else -500.0))
	
	elif coords.y != int(global_position.y):
		targets = [Vector2(450.0, int(global_position.y)), Vector2(450.0, coords.y), coords]
		if 900.0 - int(global_position.x) - coords.x > abs(-900.0 - int(global_position.x) - coords.x):
			targets = [Vector2(-450.0, int(global_position.y)), Vector2(-450.0, coords.y), coords]
	
	elif coords.x != int(global_position.x):
		targets = [coords]
	
	else:
		targets = []

func _define_direction(target: Vector2):
	return Vector2(1 if int(target.x) > int(global_position.x) else \
	-1 if int(target.x) < int(global_position.x) else 0,
	1 if int(target.y) > int(global_position.y) else \
	-1 if int(target.y) < int(global_position.y) else 0)
