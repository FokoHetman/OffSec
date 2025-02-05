extends Node2D


func run():
	var env = Env.new()
	var run = FSHInterpreter.new().evaluate(FSHParser.new().parse(FSHTokenizer.new().tokenize($Input.text)[1]), env)
	$Output.text = run.display()
func _ready():
	$Output.add_theme_font_size_override("font_size", 16)
	$Button.connect("button_up", Callable(self, "run"))
