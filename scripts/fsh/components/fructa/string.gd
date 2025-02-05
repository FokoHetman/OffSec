extends Fructa
class_name FructaString

var value

func _init(p_value: String):
	kind = Fructa.FructaKinds.String
	value = p_value

func display():
	return value
