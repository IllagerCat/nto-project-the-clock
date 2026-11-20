extends Node2D

@export var cardScene: PackedScene
@onready var timer := $Timer

var cardsTypes = [0, 0, 1, 1, 2, 2, 3, 3, 4]
var cardsPositions = \
[Vector2(-250.0, -160.0), \
Vector2(-125.0, -160.0), \
Vector2(0.0, -160.0), \
Vector2(125.0, -160.0), \
Vector2(250.0, -160.0), \
Vector2(-187.5, 13.0), \
Vector2(-62.5, 13.0), \
Vector2(62.5, 13.0), \
Vector2(187.5, 13.0)]
var openedCards = []
var canOpening = true

signal accept()
signal refuse()


func _enter_tree():
	cardsTypes.shuffle()

func _ready():
	timer.timeout.connect(_access)
	for cardIndex in range(cardsTypes.size()):
		var card = cardScene.instantiate()
		card.global_position = cardsPositions[cardIndex]
		card.cardType = cardsTypes[cardIndex]
		self.add_child(card)

@warning_ignore("unused_parameter")
func _physics_process(delta: float):
	if openedCards.size() == 2:
		canOpening = false
		if timer.is_stopped():
			timer.start()
	if cardsPositions.size() == openedCards.size() and openedCards.size() == 1:
		await get_tree().create_timer(2.0).timeout
		SignalBus.pause = false
		queue_free()

func _access():
	if openedCards[0][0] == openedCards[1][0]:
		accept.emit()
		cardsPositions.erase(Vector2(openedCards[0][1].x, \
		openedCards[0][1].y - get_tree().current_scene.get_node('Camera').global_position.y))
		cardsPositions.erase(Vector2(openedCards[1][1].x, \
		openedCards[1][1].y - get_tree().current_scene.get_node('Camera').global_position.y))
		openedCards = []
		canOpening = true
	else:
		refuse.emit()
		openedCards = []
		canOpening = true
