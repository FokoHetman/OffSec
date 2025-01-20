extends Node
class_name Token

enum Operator {
	Addition,			# +
	Substraction,		# -
	Multiplication,		# *
	Division			# /
}

enum TokenType {
	Identifier,			# __function__ x y 
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
}

var type: TokenType
var operator: Operator	# nullable


func _init(type, operator=null):
	type = type
	operator = operator
	self
