@tool
extends Node
class_name Tokenizer

enum Operator {
	Addition,			# +
	Substraction,		# -
	Multiplication,		# *
	Division			# /
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
				tokens.append(Token.new(TokenType.RBracket, null, null))
			">":
				tokens.append(Token.new(TokenType.RBracket, null, null))
			"|":
				tokens.append(Token.new(TokenType.Pipe, null, null))
			";":
				tokens.append(Token.new(TokenType.SemiColon, null, null))
			"]":
				tokens.append(Token.new(TokenType.CSParen, null, null))
			"[":
				tokens.append(Token.new(TokenType.OSParen, null, null))
			"}":
				tokens.append(Token.new(TokenType.CCParen, null, null))
			"{":
				tokens.append(Token.new(TokenType.OCParen, null, null))
			")":
				tokens.append(Token.new(TokenType.CParen, null, null))
			"(":
				tokens.append(Token.new(TokenType.OParen, null, null))
			"+":
				tokens.append(Token.new(TokenType.Operator, null, Operator.Addition))
			"-":
				tokens.append(Token.new(TokenType.Operator, null, Operator.Substraction))
			"*":
				tokens.append(Token.new(TokenType.Operator, null, Operator.Multiplication))
			"/":
				tokens.append(Token.new(TokenType.Operator, null, Operator.Division))
			"\"":
				chars.remove_at(0)
				var buffer = ""
				while chars[0]!="\"":
					buffer += chars[0]
					chars.remove_at(0)
					if len(chars)==0:
						return [false, TokenizerError.UnmatchedQuote]
				tokens.append(Token.new(TokenType.String, buffer, null))
			"\'":
				chars.remove_at(0)
				var buffer = ""
				while chars[0]!="\"":
					buffer += chars[0]
					chars.remove_at(0)
					if len(chars)==0:
						return [false, TokenizerError.UnmatchedQuote]
				tokens.append(Token.new(TokenType.String, buffer, null))
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
						tokens.append(Token.new(TokenType.Float, float(buffer), null))
					else:
						tokens.append(Token.new(TokenType.Integer, int(buffer), null))
					removable = false


				if len(chars)>0 && chars[0].is_valid_identifier():
					var buffer = chars[0]
					chars.remove_at(0)
					while (buffer + chars[0]).is_valid_identifier():
						buffer += chars[0]
						chars.remove_at(0)
					removable = false
					tokens.append(Token.new(TokenType.Identifier, buffer, null))

		if removable:
			chars.remove_at(0)
	return [true, tokens]
