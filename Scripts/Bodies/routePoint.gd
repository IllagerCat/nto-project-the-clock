extends Area2D

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Подаём сигнал в шину, когда точка нажата ЛКМ
		SignalBus.task_clicked.emit(global_position, self.name == 'Ladder1Area' or self.name == 'Ladder2Area')

func _mouse_enter():
	if self.name == 'Ladder1Area' or self.name == 'Ladder2Area':
		self.get_parent().get_node('AnimatedSprite2D').play('mouse_entered')

func _mouse_exit():
	if self.name == 'Ladder1Area' or self.name == 'Ladder2Area':
		self.get_parent().get_node('AnimatedSprite2D').play('default')
