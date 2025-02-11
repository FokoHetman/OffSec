extends Node2D

var dialog = preload("res://scenes/dialog.tscn")
var player = preload("res://scenes/player.tscn")
var player_instance

func _ready():
	add_to_group("persistence", true)
	if get_parent() && get_parent().refresh()["current_scene"].to_lower()=="intro":
		get_parent().save_game()
	
	
	if player.can_instantiate():
		player_instance = player.instantiate()
		get_parent().add_child(player_instance)
		player_instance.scale *= Vector2(3,3)
		#player_instance.position = Vector2(200,250)
	if dialog.can_instantiate():
		var instance = dialog.instantiate()
		add_child(instance)
		instance.dialog([
			["Jan Kowalski", "Kwestia1", load("res://art/portrait.png")],
			["Player", "Odpowiedź", load("res://art/patyczak.png")],
			["Jan Kowalski", "Kwestia2", load("res://art/portrait.png")],
		], player_instance)
	#write("Jan Kowalski", "hello there!!!!!!!!!!")


func _process(delta):
	pass

func save():
	return {
		"filename": get_scene_file_path()
	}
