extends Node2D
var cardsTypes = [0, 0, 1, 1, 2, 2, 3, 3, 4]
var cardsPositions = []

func _enter_tree():
	cardsTypes.shuffle()
