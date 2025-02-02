extends Node


var env

'''
enum NodeKind {
	Program,			# defined in `program.gd`
	Identifier,			# defined in `identifier.gd`
	BinaryOperation,	# defined in `binop.gd`
	Declaration,		# defined in `declaration.gd`
	
	Integer,			# literal int
	Float,				# literal float
	String,				# literal string
}
'''

func evaluate_program(program: FSHProgram, env: Env):
	var last_eval = Nullus.new()
	for i in program.body:
		last_eval = evaluate(i, env)
	return last_eval
func evaluate(node: FSHNode, env: Env):
	match node.kind:
		FSHParser.NodeKind.BinaryOperation:
			pass

func evaluate_binop(node: FSHBinaryOperation, env: Env):
	match node.operator:
		FSHTokenizer.Operator.Addition:
			pass
		FSHTokenizer.Operator.Substraction:
			pass
		FSHTokenizer.Operator.Multiplication:
			pass
