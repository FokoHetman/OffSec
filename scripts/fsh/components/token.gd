extends Node
class_name Token


var type
var value				# any (String, Int, Null, depends ok TokenType)
var operator			# nullable


func _init(ptype, pvalue, poperator):
	type = ptype
	value = pvalue
	operator = poperator
