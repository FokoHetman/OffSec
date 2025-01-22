extends Node2D


func _ready():
	var run = FSHParser.new().parse(FSHTokenizer.new().tokenize("2+2")[1])
	
	print(run.node.body[0].node.left.node, ":", run.node.body[0].node.operator, ":", run.node.body[0].node.right.node)
