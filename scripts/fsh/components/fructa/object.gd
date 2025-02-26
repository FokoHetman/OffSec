extends Fructa
class_name FructaObject

var node: Node

func _init(p_node: Node):
	kind = Fructa.FructaKinds.GameObject
	node = p_node

func raw():
	return node
func display():
	return "$" + node.name
