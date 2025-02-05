extends FSHNode
class_name FSHInt

var value: int
func _init(p_value: int):
	kind = FSHParser.NodeKind.Integer
	value = p_value
	
func display() -> String:
	return str(value)
