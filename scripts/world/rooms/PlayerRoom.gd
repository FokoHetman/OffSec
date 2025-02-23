extends Node2D

var dialog = preload("res://scenes/dialog.tscn")

func _ready():
	add_to_group("persistence", true)
	if get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="intro":
		get_parent().spawn_player(Vector2(900,600))
		get_parent().save_game()					# save after completing intro installer
	elif get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="world":
		get_parent().spawn_player(Vector2(1300,630))
	
	if get_parent() && dialog.can_instantiate():
		var instance = dialog.instantiate()
		add_child(instance)
		instance.dialog([
			["Jan Kowalski", "Kwestia1", load("res://art/portrait.png")],
			["Player", "Odpowiedź", load("res://art/patyczak.png")],
			["Jan Kowalski", "Kwestia2", load("res://art/portrait.png")],
		], get_parent().player)
	#write("Jan Kowalski", "hello there!!!!!!!!!!")
	#$Doors.connect("", )
	$Doors.connect("body_entered", Callable(self, "pls").bind(get_parent().world))

var avoid = true
func pls(who, scene):
	if !avoid:
		print("PLEASE")
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
