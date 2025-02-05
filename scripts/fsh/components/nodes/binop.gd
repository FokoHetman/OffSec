extends FSHNode
class_name FSHBinaryOperation

var left: FSHNode
var right: FSHNode
var operator: int

func _init(p_left, p_right, p_operator):
	kind = FSHParser.NodeKind.BinaryOperation
	left = p_left
	right = p_right
	operator = p_operator

'''
enum Operator {
	Addition,			# +
	Substraction,		# -
	Multiplication,		# *
	Division,			# /
	Equals,				# =
	Comparision,		# ==
}
'''
func display_operator(op):
	match op:
		FSHTokenizer.Operator.Addition:
			return "+"
		FSHTokenizer.Operator.Substraction:
			return "-"
		FSHTokenizer.Operator.Multiplication:
			return "*"
		FSHTokenizer.Operator.Division:
			return "/"
		FSHTokenizer.Operator.Equals:
			return "="
		FSHTokenizer.Operator.Comparision:
			return "=="
		_:
			return "?"

func display():
	return left.display() + display_operator(operator) + right.display()
