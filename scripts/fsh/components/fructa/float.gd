extends Fructa
class_name FructaFloat

var value: float

func _init(p_value: float):
	kind = Fructa.FructaKinds.Float
	value = p_value

func raw():
	return value

func display():
	return str(value)
