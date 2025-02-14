extends FSHNode
class_name FSHIndexation

var left
var right

func _init(p_left: FSHIdentifier, p_right: FSHIdentifier):
	kind = FSHParser.NodeKind.Indexation
	left = p_left
	right = p_right


func display():
	return left.display() + "." + right.display()
