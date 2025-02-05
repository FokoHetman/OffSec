extends FSHNode
class_name FSHFloat

var value: float
func _init(p_value: float):
	kind = FSHParser.NodeKind.Float
	value = p_value
	
func display():
	return str(value)
