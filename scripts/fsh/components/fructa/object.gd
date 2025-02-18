extends Fructa
class_name FructaObject

var node: Node

func _init(identifier: FSHIdentifier):
	kind = Fructa.FructaKinds.String
	node = get_node(identifier.symbol)

func display():
	return "$" + node.name
