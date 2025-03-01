extends Node2D


var heat_flower_scene = preload("res://scenes/flora/heat_flower.tscn")
var mouse_scene = preload("res://scenes/fauna/lantern_mouse.tscn")

var flower_positions = []#[Vector2(200,200)]
var mice_positions = [Vector2(200,200)]
var lliljana_positions = []

var dialog_scene = preload("res://scenes/dialog.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _ready():
	var translations = Translations.new()
	var language = get_parent().global_data["language"]
	var username = get_parent().global_data["username"]
	
	
	
	add_to_group("persistence", true)
	if get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="player_room":
		get_parent().spawn_player(Vector2(850,700))

	for i in flower_positions:
		var hfs = heat_flower_scene.instantiate()
		hfs.position = i
		add_child(hfs)
	for i in mice_positions:
		var mouse = mouse_scene.instantiate()
		mouse.position = i
		mouse.scale = Vector2(0.15, 0.15)
		add_child(mouse)

	$Karczma.connect("body_entered", Callable(self, "karczma").bind(get_parent().karczma))

	if dialog_scene.can_instantiate():
		var dialog = dialog_scene.instantiate()
		add_child(dialog)
		print(get_parent().global_data["progress"])
		if get_parent().global_data["progress"]==1:
			dialog.dialog([
					[translations.translations[language]["helpful_spirit"], 
					translations.translations[language]["outside.text1"].replace("player", username), load("res://art/portrait.png")],
					
					[username, translations.translations[language]["outside.text2"], load("res://art/patyczak.png")],
					
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["outside.text3"], load("res://art/portrait.png")],
					
					[username, translations.translations[language]["outside.text4"], load("res://art/patyczak.png")],
					
					[translations.translations[language]["helpful_spirit"], translations.translations[language]["outside.text5"], load("res://art/portrait.png"),
						Callable(self, "add_quest")],
				], get_parent().player)
		else:
			dialog.queue_free()


var avoid = true
func karczma(who, scene):
	if !avoid:
		get_parent().ch_scene(scene)
		print(get_parent().current_scene)
	else:
		avoid = false



func save():
	return {
		"filename": get_scene_file_path()
	}
