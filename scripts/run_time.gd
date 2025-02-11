extends Node2D


var intro = preload("res://scenes/intro.tscn")
var player_room = preload("res://scenes/player_room.tscn")
#var map = preload()


var known_scenes = {
	"intro": intro,
	"player_room": player_room,
}

var global_data = {
	"progress": 0,
	"current_scene": null,
}


var p_data = {}
var instance = true
var current_scene
func _ready():
	load_game()

func ch_scene(scene: PackedScene):
	if scene && scene.can_instantiate():
		if current_scene:
			current_scene.queue_free()
		current_scene = scene.instantiate()
		global_data["current_scene"] = current_scene.name
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
	save["progress"] = global_data["progress"]
	save["current_scene"] = global_data["current_scene"]
	save_file.store_string(JSON.stringify(save))
	save_file.close()
	

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
			if x == "position":
				print(i, x, Vector2(save_json["structure"][i][x]["x"], save_json["structure"][i][x]["y"]))
				new_object.set(x, Vector2(save_json["structure"][i][x]["x"], save_json["structure"][i][x]["y"]))
				print(new_object.position)
				continue
			new_object.set(x, save_json["structure"][i][x])
	ch_scene(known_scenes[save_json["current_scene"].to_lower()])
	save.close()
	refresh()

func refresh():			# tf is this function bro
	var file = FileAccess.open("user://save.json", FileAccess.READ)
	p_data = JSON.parse_string(file.get_as_text())
	file.close()
	return p_data

func new_game():
	ch_scene(intro)
