extends FSHNode
class_name FSHProgram

var body

func _init(p_body = []):
	body = p_body
	kind = FSHParser.NodeKind.Program

func append(item):
	body.append(item)

func display():
	print(body)
	var result = "["
	for i in body:
		result += i.display() + ", "
	result += "]"
	return result
