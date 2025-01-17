@tool
extends Node
class_name Tokenizer

func chars(str: String) -> Array:
	var array = []
	for i in str:
		array.append(i)
	return array

func _init():
	pass

func tokenize(code: String):

	var chars = chars(code)
	while chars.len()>0:
		match chars[0]:
			_:
				pass
		chars.remove(0)
