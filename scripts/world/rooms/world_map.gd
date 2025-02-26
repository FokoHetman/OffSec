extends Node2D


var heat_flower_scene = preload("res://scenes/flora/heat_flower.tscn")
var mouse_scene = preload("res://scenes/fauna/lantern_mouse.tscn")

var flower_positions = []#[Vector2(200,200)]
var mice_positions = [Vector2(200,200)]
var lliljana_positions = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _ready():
	add_to_group("persistence", true)
	if get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="player_room":
		get_parent().spawn_player(Vector2(800,700))

	for i in flower_positions:
		var hfs = heat_flower_scene.instantiate()
		hfs.position = i
		add_child(hfs)
	for i in mice_positions:
		var mouse = mouse_scene.instantiate()
		mouse.position = i
		mouse.scale = Vector2(0.15, 0.15)
		add_child(mouse)
func save():
	return {
		"filename": get_scene_file_path()
	}
