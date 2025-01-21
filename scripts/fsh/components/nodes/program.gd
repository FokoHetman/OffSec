extends Node
class_name FSHProgram

var body

func _init(p_body = []):
	body = p_body

func append(item):
	body.append(item)
