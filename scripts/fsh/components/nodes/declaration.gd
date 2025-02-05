extends FSHNode
class_name FSHDeclaration

var identifier
var body

func _init(p_identifier: FSHIdentifier, p_body: FSHNode):
	kind = FSHParser.NodeKind.Declaration
	body = p_body
	identifier = p_identifier


func display():
	return identifier.display() + " = " + body.display()
