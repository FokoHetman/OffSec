extends Node
class_name FSHParser


enum NodeKind {
	Program,			# defined in `program.gd`
	Identifier,			# defined in `identifier.gd`
	BinaryOperation,	# defined in `binop.gd`
	Integer,			# literal int
	Float,				# literal float
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
	var result = FSHNode.new(NodeKind.Program, FSHProgram.new())
	while tokens[0].type != tokenizer.TokenType.EOF:
		result.node.append(parseSTMT())
	return result

func parseSTMT():
	var left = parse_additive_expr()
	if tokens[0].type==tokenizer.TokenType.Operator && tokens[0].operator==tokenizer.Operator.Equals:
		pass
	return left

func parse_additive_expr():
	var left = parse_primary_expr()
	while tokens[0].type==tokenizer.TokenType.Operator && tokens[0].operator==tokenizer.Operator.Addition:
		var operator = eat().operator
		left = FSHNode.new(NodeKind.BinaryOperation, FSHBinaryOperation.new(left, parse_primary_expr(), operator))
	return left

func parse_primary_expr():
	var eat = eat()
	match eat.type:
		tokenizer.TokenType.Float:
			return FSHNode.new(NodeKind.Float, eat.value)
		tokenizer.TokenType.Integer:
			return FSHNode.new(NodeKind.Integer, eat.value)
		_:
			error = [true, ParserError.UnexpectedToken, eat]
			return false
