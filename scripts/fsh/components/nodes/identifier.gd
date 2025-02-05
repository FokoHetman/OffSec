extends FSHNode
class_name FSHIdentifier

var symbol: String
var children

func _init(p_symbol: String, p_children=[]):
	kind = FSHParser.NodeKind.Identifier
	symbol = p_symbol
	children = p_children

func display() -> String:
	var result = symbol + "["
	for i in children:
		result += i.display() + ", "
	return result + "]"
