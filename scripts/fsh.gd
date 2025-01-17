extends Node


var tokenizer
var parser
var env
var interpreter
# Called when the node enters the scene tree for the first time.
func _ready():
	tokenizer = preload("res://scripts/fsh/tokenizer.gd").new()
	parser = preload("res://scripts/fsh/parser.gd").new()
	env = preload("res://scripts/fsh/env.gd").new()
	interpreter = preload("res://scripts/fsh/interpreter.gd").new(env)



func run(code: String) -> Fructa:
	return interpreter.evaluate(parser.parse(tokenizer.tokenize(code)))
