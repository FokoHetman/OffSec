extends Node2D

var dialog = preload("res://scenes/dialog.tscn")
var player = preload("res://scenes/player.tscn")

func _ready():
	if player.can_instantiate():
		var instance = player.instantiate()
		add_child(instance)
		instance.position = Vector2(200,250)
	if dialog.can_instantiate():
		var instance = dialog.instantiate()
		add_child(instance)
		instance.dialog([
			["Jan Kowalski", "Kwestia1", load("res://art/portrait.png")],
			["Player", "Odpowiedź", load("res://art/patyczak.png")],
			["Jan Kowalski", "Kwestia2", load("res://art/portrait.png")],
		])
	#write("Jan Kowalski", "hello there!!!!!!!!!!")
