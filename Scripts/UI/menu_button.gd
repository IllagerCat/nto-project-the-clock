extends Area2D

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if self.name == 'Exit':
			get_tree().quit()
		get_tree().change_scene_to_file("res://Scenes/World/clock.tscn")

func _mouse_enter():
	scale = Vector2(1.1, 1.1)

func _mouse_exit():
	scale = Vector2(1.0, 1.0)
