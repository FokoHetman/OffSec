extends Node2D


var intro = preload("res://scenes/intro.tscn")
var player_room = preload("res://scenes/player_room.tscn")
#var map = preload()

var instance = true
var current_scene
func _ready():
	ch_scene(intro)

func ch_scene(scene: PackedScene):
	if scene && scene.can_instantiate():
		current_scene = scene.instatiate()
		add_child(current_scene)
		return true
	return false
