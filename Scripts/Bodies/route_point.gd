extends Area2D

@export var memoScene: PackedScene

func _ready():
	if self.name != 'Ladder1Area' and self.name != 'Ladder2Area':
		self.body_entered.connect(_task_start)

func _input_event(_viewport, event, _shape_idx):
	if not SignalBus.pause:
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			SignalBus.task_clicked.emit(global_position, self.name == 'Ladder1Area' or self.name == 'Ladder2Area')

func _mouse_enter():
	if not SignalBus.pause:
		if self.name == 'Ladder1Area' or self.name == 'Ladder2Area':
			self.get_parent().get_node('AnimatedSprite2D').play('mouse_entered')

func _mouse_exit():
	if not SignalBus.pause:
		if self.name == 'Ladder1Area' or self.name == 'Ladder2Area':
			self.get_parent().get_node('AnimatedSprite2D').play('default')

func _task_start(body):
	if body.name == 'Player':
		if global_position in body.targets:
			SignalBus.pause = true
			var memo = memoScene.instantiate()
			var cam_pos = get_tree().current_scene.get_node('Camera').global_position
			get_tree().current_scene.add_child.call_deferred(memo)
			memo.set_deferred("global_position", cam_pos)
			get_parent().queue_free()
