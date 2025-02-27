extends Node2D
class_name RuntimeNode

### RUNTIME



func save():
	return {
		"filename": get_scene_file_path(),
		"position": {"x": position.x, "y": position.y},
		"rotation": rotation,
	}

### FSH

func move(x, y):
	position += Vector2(x, y)
