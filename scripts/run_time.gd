extends Node2D


var intro = preload("res://scenes/intro.tscn")
var player_room = preload("res://scenes/player_room.tscn")
var player_scene = preload("res://scenes/player.tscn")
var world = preload("res://scenes/world_map.tscn")

var fsh = preload("res://scenes/fsh_terminal.tscn") 
var fsh_scene

var settings = preload("res://scenes/settings.tscn") 
var settings_scene 

var karczma = preload("res://scenes/karczma.tscn") 
#var map = preload()


var known_scenes = {
	"intro": intro,
	"player_room": player_room,
	"world_map": world,
	"karczma": karczma,
}

var global_data = {
	"progress": 0,
	"language": "en_US",
	"username": "player",
	"current_scene": null,
}


var p_data = {}
var instance = true
var current_scene
var player
func _ready():
	$CanvasLayer/Task.add_theme_font_size_override("font_size", 20)
	$CanvasLayer/Task.add_theme_color_override("font_color", Color.YELLOW)
	load_game()

var tick = 0
func _process(delta):
	if tick % 20 == 0 && global_data["progress"]!=0:
		$CanvasLayer/Task.text = Translations.new().translations[global_data["language"]]["task"] + ":\n" + Translations.new().translations[global_data["language"]]["tasks." + str(global_data["progress"])]
	tick += 1


func ch_scene(scene: PackedScene):
	if scene && scene.can_instantiate():
		if current_scene:
			current_scene.queue_free()
		current_scene = scene.instantiate()
		global_data["current_scene"] = current_scene.name
		add_child(current_scene)
		return true
	return false

func spawn_player(at: Vector2):
	if !player:
		if !player_scene.can_instantiate():
			return false
		player = player_scene.instantiate()
		add_child(player)
	player.position = at

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
	create_settings()
	create_fsh()
	if !FileAccess.file_exists("user://save.json"):
		new_game()
		return
	var save = FileAccess.open("user://save.json", FileAccess.READ)
	var save_json = JSON.parse_string(save.get_as_text())
	
	
	
	
	
	global_data["language"] = save_json["language"]
	global_data["username"] = save_json["username"]
	global_data["progress"] = save_json["progress"]
	
	
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
		if i.to_lower()=="player":
			player = new_object
			add_child(player)
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

func create_settings():
	settings_scene = settings.instantiate()
	settings_scene.get_node('CanvasLayer').hide()
	add_child(settings_scene)
	settings_scene.get_node('CanvasLayer').layer = 5

func create_fsh():
	fsh_scene = fsh.instantiate()
	add_child(fsh_scene)



func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_TAB:
			if fsh_scene.get_node("CanvasLayer").visible:
				fsh_scene.get_node("CanvasLayer").hide()
			else:
				fsh_scene.get_node("CanvasLayer").show()
		elif event.keycode == KEY_ESCAPE:
			if !settings_scene.get_node('CanvasLayer').visible:
				settings_scene.get_node('CanvasLayer').show()
				settings_scene.back_to_main()
			else:
				settings_scene.get_node('CanvasLayer').hide()
