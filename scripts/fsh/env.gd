@tool
extends Node
class_name Env

var functions = []
var aliases = []

func _init():
	pass

func declare(id: FSHIdentifier, value: FSHNode):
	functions.append([id, value])
	
func resolve(id : FSHIdentifier):
	for i in functions:
		if i[0]==id: # check children too
			pass

func display():
	print("ENV")
	for i in functions:
		print(i[0].display(), i[1].display())
	print("END_ENV")

func get_fun(id: FSHIdentifier):
	for i in functions:
		if id.symbol==i[0].symbol:
			return i
	return Nullus.new()
