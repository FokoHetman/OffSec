extends Fructa
class_name FructaInt

var value: int
func _init(p_value: int):
	kind = Fructa.FructaKinds.Int
	value = p_value

func raw():
	return value

func display():
	return str(value)
