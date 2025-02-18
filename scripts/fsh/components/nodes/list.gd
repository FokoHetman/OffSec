extends FSHNode
class_name FSHList

var body
func _init(p_body):
	kind = FSHParser.NodeKind.List
	body = p_body
	
func display() -> String:
	var result = "["
	for i in body:
		result += i.display() + ", "
	result += "]"
	return result
 
