extends Node
class_name FSHDeclaration

var identifier
var body

func _init(p_identifier: FSHIdentifier, p_body: FSHNode):
	body = p_body
	identifier = p_identifier
