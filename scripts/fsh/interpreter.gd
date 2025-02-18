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
		print("le: ", last_eval)
	return last_eval
func evaluate(node: FSHNode, env: Env):
	#print(node.display())
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
		FSHParser.NodeKind.List:
			return evaluate_list(node, env)
		FSHParser.NodeKind.Struct:
			return evaluate_struct(node, env)
		FSHParser.NodeKind.Indexation:
			return evaluate_indexation(node, env)
		FSHParser.NodeKind.Matterializator:
			return evaluate_matterializator(node, env)
		_:
			print("skipped")

func evaluate_list(node: FSHList, env: Env):
	var result = []
	for i in node.body:
		result.append(evaluate(i, env))
	return FructaList.new(result)
func evaluate_struct(node: FSHStruct, env: Env):
	var definitions = []
	for i in node.definitions:
		definitions.append([i[0], evaluate(i[1], env)])
	return FructaStruct.new(definitions)
func evaluate_indexation(node: FSHIndexation, env: Env):
	var left = evaluate(node.left, env)
	match left.kind:
		Fructa.FructaKinds.Struct:
			for i in left.definitions:
				#print(i[0].display(), node.right.display())
				if i[0].symbol==node.right.symbol:
					return i[1]
		Fructa.FructaKinds.List:
			var right = evaluate(node.right, env)
			match right.kind:
				Fructa.FructaKinds.Int:
					return left.body[right.value]
		Fructa.FructaKinds.GameObject:
			pass


func evaluate_matterializator(node: FSHMatterializator, env: Env):
	pass


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
