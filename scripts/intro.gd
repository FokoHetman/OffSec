extends Node2D

var questions = []

func _ready():
	$CanvasLayer/Continue.connect("button_down", Callable(self, "question"))
	var language_choice = OptionButton.new()
	language_choice.add_item("English", 0)		# DOES NOTHING !!!
	language_choice.add_item("Polish", 1)
	questions.append([
		"Language",
		language_choice,
		Callable(self, "setup_language")
	])
	var username_input = LineEdit.new()
	questions.append([
		"Username",
		username_input,
		Callable(self, "setup_username")
	])

var last_child
var last_callable
func question():
	if last_child:
		$CanvasLayer.remove_child(last_child)
	if last_callable:
		last_callable.call()
	if len(questions)>0:
		$CanvasLayer/Question.text = questions[0][0]
		last_child = questions[0][1]
		last_callable = questions[0][2]
		last_child.position = Vector2(150,120)
		$CanvasLayer.add_child(last_child)
		questions.remove_at(0)
	else:
		$CanvasLayer.queue_free()
		pass # destroy the wizard window and enter the game here

### TODO
func setup_language():
	pass
func setup_username():
	pass
