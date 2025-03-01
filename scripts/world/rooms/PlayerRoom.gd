extends Node2D

var dialog = preload("res://scenes/dialog.tscn")


func _ready():
	var translations = Translations.new()
	var language = get_parent().global_data["language"]
	var username = get_parent().global_data["username"]
	add_to_group("persistence", true)
	if get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="intro":
		get_parent().spawn_player(Vector2(900,600))
		get_parent().save_game()					# save after completing intro installer
	elif get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="world":
		get_parent().spawn_player(Vector2(1300,630))
	
	if get_parent() && dialog.can_instantiate():
		var instance = dialog.instantiate()
		add_child(instance)
		if get_parent().global_data["progress"]==0:
			instance.dialog([
				[translations.translations[language]["helpful_spirit"], 
				translations.translations[language]["player_room.text1"].replace("player", username), load("res://art/portrait.png")],
				
				[username, translations.translations[language]["player_room.text2"], load("res://art/patyczak.png")],
				
				[translations.translations[language]["helpful_spirit"], translations.translations[language]["player_room.text3"], load("res://art/portrait.png")],
				
				[username, translations.translations[language]["player_room.text4"], load("res://art/patyczak.png")],
				
				[translations.translations[language]["helpful_spirit"], translations.translations[language]["player_room.text5"], load("res://art/portrait.png"),
					Callable(self, "add_quest")],
			], get_parent().player)
		else:
			instance.queue_free()

	$Doors.connect("body_entered", Callable(self, "doors").bind(get_parent().world))


func add_quest():
	get_parent().global_data["progress"] += 1



var avoid = true
func doors(who, scene):
	if !avoid:
		get_parent().ch_scene(scene)
		print(get_parent().current_scene)
	else:
		avoid = false
func _process(delta):
	pass

func save():
	return {
		"filename": get_scene_file_path()
	}
