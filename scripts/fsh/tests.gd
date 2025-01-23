extends Node2D


func _ready():
	var run = FSHParser.new().parse(FSHTokenizer.new().tokenize("help=2")[1])
	
	print(run.node.body[0].node.left.node.symbol, ":", run.node.body[0].node.operator, ":", run.node.body[0].node.right.node)
