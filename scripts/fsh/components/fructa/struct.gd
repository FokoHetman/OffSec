extends Fructa
class_name FructaStruct

var definitions

func _init(p_defs):
	kind = Fructa.FructaKinds.Struct
	definitions = p_defs

func display() -> String:
	var result = "{"
	for i in definitions:
		result += i[0].display() + " = " + i[1].display() + "; "
	if result.ends_with("; "):
		for i in range(2):
			result.erase(-1)
	result += "}"
	return result
 
