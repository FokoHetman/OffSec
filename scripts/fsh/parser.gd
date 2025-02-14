extends Node
class_name FSHParser


enum NodeKind {
	Program,			# defined in `program.gd`
	Identifier,			# defined in `identifier.gd`
	BinaryOperation,	# defined in `binop.gd`
	
	Declaration,		# defined in `declaration.gd`
	Indexation,			# defined in `indexation.gd`
	
	Integer,			# literal int
	Float,				# literal float
	String,				# literal string
	Nullus,
}

enum ParserError {
	UnexpectedToken,
}

var tokenizer = FSHTokenizer.new()


var tokens						# I do parsers a weird way, thus this is global
var error = [false, -1, -1]		# [errored, error_id, value]

func at():
	return tokens[0]
func eat():
	var tok = tokens[0]
	tokens.remove_at(0)
	return tok
func eatExpect(type):
	var tok = tokens[0]
	if type != tok.type:
		error = [true, ParserError.UnexpectedToken, tok]
		return false
	return tok
func parse(p_tokens):
	tokens = p_tokens
	var result = FSHProgram.new()
	while tokens[0].type != tokenizer.TokenType.EOF:
		result.append(parseSTMT())
	return result

func parseSTMT(deep = true):
	var left = parse_multiplicative_expr()
	if tokens[0].type==tokenizer.TokenType.Operator && tokens[0].operator==tokenizer.Operator.Equals:
		var operator = eat().operator
		left = FSHDeclaration.new(left, parse_multiplicative_expr(deep))
	return left

func parse_multiplicative_expr(deep = true):
	var left = parse_additive_expr(deep)
	while tokens[0].type==tokenizer.TokenType.Operator && tokens[0].operator in [tokenizer.Operator.Multiplication, tokenizer.Operator.Division]:
		var operator = eat().operator
		left = FSHBinaryOperation.new(left, parse_additive_expr(deep), operator)
	return left

func parse_additive_expr(deep = true):
	var left = parse_indexation(deep)
	while tokens[0].type==tokenizer.TokenType.Operator && tokens[0].operator in [tokenizer.Operator.Addition, tokenizer.Operator.Substraction]:
		var operator = eat().operator
		left = FSHBinaryOperation.new(left, parse_indexation(deep), operator)
	return left


func parse_indexation(deep = true):
	var left = parse_primary_expr(deep)
	while tokens[0].type == tokenizer.TokenType.Indexation:
		left = FSHIndexation.new(left, parse_primary_expr(deep))
	return left


func parse_primary_expr(deep = true):
	var eat = eat()
	match eat.type:
		tokenizer.TokenType.String:
			return eat.value
		tokenizer.TokenType.Identifier:
			var children = []
			if deep:
				while !(at().type in [tokenizer.TokenType.EOF, tokenizer.TokenType.SemiColon, tokenizer.TokenType.Operator]):
					children.append(self.parse_multiplicative_expr(false))# -- I have no idea what should be there actually
			#children.kill() -- don't
			return FSHIdentifier.new(eat.value, children)
		tokenizer.TokenType.Float:
			return FSHFloat.new(eat.value)
		tokenizer.TokenType.Integer:
			return FSHInt.new(eat.value)
		tokenizer.TokenType.SemiColon:
			return FSHNullus.new()
		tokenizer.TokenType.Operator:
			if eat.operator == tokenizer.Operator.Substraction:
				var eat2 = self.eat()
				match eat2.type:
					tokenizer.TokenType.Float:
						return FSHFloat.new(-eat2.value)
					tokenizer.TokenType.Integer:
						return FSHInt.new(-eat2.value)
		_:
			error = [true, ParserError.UnexpectedToken, eat]
			return false
