extends Node2D


func _ready():
	var player = preload("res://scenes/player.tscn")
	if player.can_instantiate():
		print("ha!")
		var instance = player.instantiate()
		add_child(instance)
		instance.position = Vector2(200,250)
