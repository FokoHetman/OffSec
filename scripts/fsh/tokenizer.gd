extends Node
class_name FSHTokenizer

enum Operator {
	Addition,			# +
	Substraction,		# -
	Multiplication,		# *
	Division,			# /
	Equals,				# =
	Comparision,		# ==
}

enum TokenType {
	Identifier,			# __function__ x y 
	String,				# "hello there"
	Integer,			# 5
	Float,				# 6.8

	Operator,			# Operator enum
	OParen,				# (
	CParen,				# )
	OCParen,			# {
	CCParen,			# }
	OSParen,			# [
	CSParen,			# ]
	
	SemiColon,			# ;
	Pipe,				# |
	LBracket,			# <
	RBracket,			# >
	
	Quote,				# "
	LQuote,				# '
	
	EOF,				# End Of File/Input
}

enum TokenizerError {
	UnmatchedQuote
}

func chars(str: String) -> Array:
	var array = []
	for i in str:
		array.append(i)
	return array

func _init():
	pass


func tokenize(code: String):
	var chars = chars(code)
	var tokens = []
	while len(chars)>0:
		var removable = true
		match chars[0]:
			"<":
				tokens.append(FSHToken.new(TokenType.RBracket, null, null))
			">":
				tokens.append(FSHToken.new(TokenType.RBracket, null, null))
			"|":
				tokens.append(FSHToken.new(TokenType.Pipe, null, null))
			";":
				tokens.append(FSHToken.new(TokenType.SemiColon, null, null))
			"]":
				tokens.append(FSHToken.new(TokenType.CSParen, null, null))
			"[":
				tokens.append(FSHToken.new(TokenType.OSParen, null, null))
			"}":
				tokens.append(FSHToken.new(TokenType.CCParen, null, null))
			"{":
				tokens.append(FSHToken.new(TokenType.OCParen, null, null))
			")":
				tokens.append(FSHToken.new(TokenType.CParen, null, null))
			"(":
				tokens.append(FSHToken.new(TokenType.OParen, null, null))
			"+":
				tokens.append(FSHToken.new(TokenType.Operator, null, Operator.Addition))
			"-":
				tokens.append(FSHToken.new(TokenType.Operator, null, Operator.Substraction))
			"*":
				tokens.append(FSHToken.new(TokenType.Operator, null, Operator.Multiplication))
			"/":
				tokens.append(FSHToken.new(TokenType.Operator, null, Operator.Division))
			"=":
				tokens.append(FSHToken.new(TokenType.Operator, null, Operator.Equals))
			"\"":
				chars.remove_at(0)
				var buffer = ""
				while chars[0]!="\"":
					buffer += chars[0]
					chars.remove_at(0)
					if len(chars)==0:
						return [false, TokenizerError.UnmatchedQuote]
				tokens.append(FSHToken.new(TokenType.String, buffer, null))
			"\'":
				chars.remove_at(0)
				var buffer = ""
				while chars[0]!="\"":
					buffer += chars[0]
					chars.remove_at(0)
					if len(chars)==0:
						return [false, TokenizerError.UnmatchedQuote]
				tokens.append(FSHToken.new(TokenType.String, buffer, null))
			_:
				if chars[0].is_valid_int():
					var buffer = chars[0]
					chars.remove_at(0)
					while len(chars)>0 && (buffer + chars[0]).is_valid_int():
						buffer += chars[0]
						chars.remove_at(0)
					if len(chars)>0 && chars[0]==".":
						buffer += chars[0]
						chars.remove_at(0)
						while len(chars)>0 && (buffer+chars[0]).is_valid_float():
							buffer += chars[0]
							chars.remove_at(0)
						tokens.append(FSHToken.new(TokenType.Float, float(buffer), null))
					else:
						tokens.append(FSHToken.new(TokenType.Integer, int(buffer), null))
					removable = false


				if len(chars)>0 && chars[0].is_valid_identifier():
					var buffer = chars[0]
					chars.remove_at(0)
					while len(chars)>0 && (buffer + chars[0]).is_valid_identifier():
						buffer += chars[0]
						chars.remove_at(0)
					removable = false
					tokens.append(FSHToken.new(TokenType.Identifier, buffer, null))

		if removable:
			chars.remove_at(0)
	tokens.append(FSHToken.new(TokenType.EOF, null, null))
	return [true, tokens]
