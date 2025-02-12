extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _ready():
	add_to_group("persistence", true)
	if get_parent().has_method("refresh") && get_parent().refresh()["current_scene"].to_lower()=="player_room":
		get_parent().spawn_player(Vector2(220,200))

func save():
	return {
		"filename": get_scene_file_path()
	}
