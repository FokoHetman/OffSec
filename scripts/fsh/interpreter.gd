extends Node
class_name FSHInterpreter

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
	print(program.display())
	for i in program.body:
		last_eval = evaluate(i, env)
	return last_eval
func evaluate(node: FSHNode, env: Env):
	#env.display()
	match node.kind:
		FSHParser.NodeKind.Integer:
			return FructaInt.new(node.value)
		FSHParser.NodeKind.Float:
			return FructaFloat.new(node.value)
		FSHParser.NodeKind.BinaryOperation:
			return evaluate_binop(node, env)
		FSHParser.NodeKind.Program:
			return evaluate_program(node, env)
		FSHParser.NodeKind.Identifier:
			return evaluate_id(node, env)
		FSHParser.NodeKind.Declaration:
			return evaluate_declaration(node, env)
		_:
			print("skipped")

func evaluate_binop(node: FSHBinaryOperation, env: Env):
	match node.operator:
		FSHTokenizer.Operator.Addition:
			var left = evaluate(node.left, env)
			match left.kind:
				Fructa.FructaKinds.Int:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value+right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value+right.value)
						Fructa.FructaKinds.String:
							return FructaString.new(str(left.value) + right.value)
				Fructa.FructaKinds.Float:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value+right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value+right.value)
						Fructa.FructaKinds.String:
							return FructaString.new(str(left.value) + right.value)
				Fructa.FructaKinds.String:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value+str(right.value))
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value+str(right.value))
						Fructa.FructaKinds.String:
							return FructaString.new(left.value + right.value)
		FSHTokenizer.Operator.Substraction:
			var left = evaluate(node.left, env)
			match left.kind:
				Fructa.FructaKinds.Int:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value-right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value-right.value)
				Fructa.FructaKinds.Float:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value+right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value+right.value)
		FSHTokenizer.Operator.Multiplication:
			var left = evaluate(node.left, env)
			match left.kind:
				Fructa.FructaKinds.Int:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value*right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value*right.value)
						Fructa.FructaKinds.String:
							return FructaString.new(str(left.value) * right.value)
				Fructa.FructaKinds.Float:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value*right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value*right.value)
				Fructa.FructaKinds.String:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value*str(right.value))

		FSHTokenizer.Operator.Division:
			var left = evaluate(node.left, env)
			match left.kind:
				Fructa.FructaKinds.Int:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value/right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value/right.value)
				Fructa.FructaKinds.Float:
					var right = evaluate(node.right, env)
					match right.kind:
						Fructa.FructaKinds.Int:
							return FructaInt.new(left.value/right.value)
						Fructa.FructaKinds.Float:
							return FructaFloat.new(left.value/right.value)



func evaluate_declaration(node: FSHDeclaration, env: Env):
	env.declare(node.identifier, node.body)
	return Nullus.new()


func evaluate_id(node: FSHIdentifier, env: Env):	### TO DO
	var t_env = Env.new()
	var data = env.get_fun(node)
	for i in range(len(data[0].children)):
		t_env.declare(data[0].children[i], node.children[i])
	return evaluate(data[1], t_env)
