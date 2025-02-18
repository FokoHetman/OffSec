extends FSHNode
class_name FSHStruct

var definitions
func _init(p_definitions):
	kind = FSHParser.NodeKind.Struct
	definitions = p_definitions
	
func display() -> String:
	var result = "{"
	for i in definitions:
		result += i[0].display() + " = " + i[1].display() + "; "
	result += "}"
	return result
 
