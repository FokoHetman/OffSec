extends Node2D

var c_node
var dialog_scene = preload("res://scenes/dialog.tscn")
var translations = Translations.new()

var language

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
	
	
	language = get_parent().global_data["language"]
	$CanvasLayer.hide()
	$CanvasLayer/Input.add_theme_font_size_override("font_size", 20)
	$CanvasLayer/Output.add_theme_font_size_override("font_size", 20)
	$CanvasLayer/Button.connect("button_up", Callable(self, "run"))

func add_quest():
	get_parent().global_data["progress"]+=1


var dialog_spawned = false

func _process(d):
	c_node = get_parent().current_scene
	
	if $CanvasLayer.visible && not dialog_spawned:
		if get_parent().global_data["progress"]==2:
			dialog_spawned = true
			if dialog_scene.can_instantiate():
				var dialog = dialog_scene.instantiate()
				add_child(dialog)
				if get_parent().global_data["progress"]==2:
					dialog.dialog([
						[translations.translations[language]["helpful_spirit"], 
						translations.translations[language]["fsh.text1"], load("res://art/portrait.png")],
						
						
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text2"], load("res://art/portrait.png")],
						
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text3"], load("res://art/portrait.png")],
						
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text4"], load("res://art/portrait.png")],
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text5"], load("res://art/portrait.png")],
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text6"], load("res://art/portrait.png")],
						
						[translations.translations[language]["helpful_spirit"], translations.translations[language]["fsh.text7"], load("res://art/portrait.png"),
						Callable(self, "add_quest")]
						], get_parent().player
					)
				else:
					dialog.queue_free()
