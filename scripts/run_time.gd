extends Node2D


var intro = preload("res://scenes/intro.tscn")
var player_room = preload("res://scenes/player_room.tscn")
#var map = preload()

var p_data = {}
var instance = true
var current_scene
var queued_scenes = []
func _ready():
	load_game()


func _process(d):
	if !current_scene && len(queued_scenes)>0:
		current_scene = queued_scenes[0].instantiate()
		add_child(current_scene)
		queued_scenes.remove_at(0)
		save_game()

func ch_scene(scene: PackedScene):
	if scene && scene.can_instantiate():
		current_scene = scene.instantiate()
		add_child(current_scene)
		return true
	return false

func save_game():
	var save_file = FileAccess.open("user://save.json", FileAccess.READ_WRITE)
	var save = JSON.parse_string(save_file.get_as_text())
	for i in get_tree().get_nodes_in_group("persistence"):
		if !i.has_method("save") || i.scene_file_path.is_empty():
			continue
		
		
		save["structure"][i.name] = i.call("save")
	save_file.store_string(JSON.stringify(save))
	

func load_game():
	if !FileAccess.file_exists("user://save.json"):
		new_game()
		return
	var save = FileAccess.open("user://save.json", FileAccess.READ)
	var save_json = JSON.parse_string(save.get_as_text())
	for i in save_json["structure"]:
		var new_object = load(save_json["structure"][i]["filename"]).instantiate()
		for x in save_json["structure"][i].keys():
			if x == "filename" or x == "parent":
				continue
			new_object.set(i, save_json["structure"][i][x])
	refresh()

func refresh():
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	p_data = JSON.parse_string(file.get_as_text())
	return p_data

func new_game():
	ch_scene(intro)
	queued_scenes.append(player_room)
