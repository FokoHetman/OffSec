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
		var removable = true
		match chars[0]:
			
			"\"":
				pass
			_:
				if chars[0].is_valid_int():
					var buffer = chars[0]
					chars.remove(0)
					while (buffer + chars[0]).is_valid_int():
						buffer += chars[0]
						chars.remove(0)
					if chars[0]==".":
						buffer += chars[0]
						chars.remove(0)
						while (buffer+chars[0]).is_valid_float():
							buffer += chars[0]
							chars.remove(0)
					removable = false
				if chars[0].is_valid_identifier():
					var buffer = chars[0]
					chars.remove(0)
					while (buffer + chars[0]).is_valid_identifier():
						buffer += chars[0]
						chars.remove(0)
					removable = false
		if removable:
			chars.remove(0)
