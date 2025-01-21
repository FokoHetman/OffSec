extends Node
class_name FSHToken


var type				# defined by TokenType in `tokenizer.gd`
var value				# any (String, Int, Null, depends ok TokenType)
var operator			# defined by Operator in `tokenizer.gd`


func _init(ptype, pvalue, poperator):
	type = ptype
	value = pvalue
	operator = poperator
