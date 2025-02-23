extends RuntimeNode


var translations = Translations.new()
var questions = []
var config = {}
var languages = [
	["English", "en_US"],
	["Polski", "pl_PL"]
]
var priviledges = [
	"root",
	"user",
]
var language_choice
func _ready():
	$CanvasLayer/Continue.connect("button_down", Callable(self, "question"))
	language_choice = OptionButton.new()

	for i in range(len(languages)):
		language_choice.add_item(languages[i][0], i)
	questions.append([
		"Language",
		language_choice,
		Callable(self, "setup_language"),
		translations.translations[languages[language_choice.selected][1]]["intro.translations_desc"],
	])
	var username_input = LineEdit.new()
	username_input.size = Vector2(30, 3)
	questions.append([
		"Username",
		username_input,
		Callable(self, "setup_username"),
		translations.translations[languages[language_choice.selected][1]]["intro.username_desc"],
	])
	
	var priviledge_choice = OptionButton.new()
	for i in range(len(priviledges)):
		priviledge_choice.add_item(translations.translations[languages[language_choice.selected][1]][priviledges[i]], i)
	questions.append([
		"Priviledge",
		priviledge_choice,
		Callable(self, "setup_priviledge"),
		translations.translations[languages[language_choice.selected][1]]["intro.priviledge_desc"],
	])

var last_lang = 0
var indexes = ["intro.translations_desc", "intro.username_desc", "intro.priviledge_desc"]
func _process(delta):
	if language_choice:
		if language_choice.selected != last_lang:
			$CanvasLayer/Desc.text = translations.translations[languages[language_choice.selected][1]]["intro.translations_desc"]
			$CanvasLayer/Continue.text = translations.translations[languages[language_choice.selected][1]]["intro.continue"]
			last_lang = language_choice.selected
			for i in range(len(questions)):
				questions[i][3] = translations.translations[languages[language_choice.selected][1]][indexes[i+1]]

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
		last_child.position = Vector2(150,150)
		$CanvasLayer.add_child(last_child)
		
		$CanvasLayer/Desc.text = questions[0][3]
		questions.remove_at(0)
	else:
		save_config()
		if get_parent():
			get_parent().save_game()
			get_parent().ch_scene(get_parent().player_room)
		
		#queue_free() # this MUST be done somehow else
		pass # destroy the wizard window and enter the game here

### TODO
func setup_language():
	config["language"] = languages[last_child.selected][1]
func setup_username():
	config["username"] = last_child.text
func setup_priviledge():
	config["priviledge"] = priviledges[last_child.selected]

func save_config():
	config["structure"] = {}
	var config_file = FileAccess.open("user://save.json", FileAccess.WRITE)
	var node_data = config
	var json_string = JSON.stringify(node_data)
	config_file.store_line(json_string)



'''RUNTIME FUNCTIONS'''
