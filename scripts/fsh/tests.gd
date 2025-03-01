extends Node2D

var c_node

func run():
	var env = Env.new()
	var tokenizer = FSHTokenizer.new()
	var parser = FSHParser.new()
	var interpreter = FSHInterpreter.new(c_node)
	
	var tokenized_result = tokenizer.tokenize($CanvasLayer/Input.text)	# [status, body]
	if !tokenized_result[0]:
		return
	var parsed_result = parser.parse(tokenized_result[1])		# [status, body]
	if !parsed_result[0]:
		return
	var run = interpreter.evaluate(parsed_result[1], env)		# [status, body]

	if run[0]:
		$CanvasLayer/Output.text = run[1].display()

func _ready():
	$CanvasLayer.hide()
	$CanvasLayer/Output.add_theme_font_size_override("font_size", 16)
	$CanvasLayer/Button.connect("button_up", Callable(self, "run"))

func _process(d):
	c_node = get_parent().current_scene
