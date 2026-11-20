extends Area2D

@onready var typeSprytes := $AnimatedSprite2D
var cardType: int
var isOpened := false
var memoManager: Node2D

func _ready():
	memoManager = get_parent()
	memoManager.accept.connect(_acceptance)
	memoManager.refuse.connect(_refusal)

func _mouse_enter():
	if not isOpened and memoManager.canOpening:
		scale = Vector2(1.1, 1.1)

func _mouse_exit():
	scale = Vector2(1.0, 1.0)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not isOpened and memoManager.canOpening:
			memoManager.openedCards.append([cardType, global_position])
			isOpened = true
			typeSprytes.play('bottom_' + str(cardType))

func _refusal():
	if isOpened:
		isOpened = false
		typeSprytes.play("top")

func _acceptance():
	if isOpened:
		queue_free()
