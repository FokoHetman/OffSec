extends Fructa
class_name FructaList

var body

func _init(p_body):
	kind = Fructa.FructaKinds.List
	body = p_body

func display() -> String:
	var result = "["
	for i in body:
		result += i.display() + ", "
	result += "]"
	return result
