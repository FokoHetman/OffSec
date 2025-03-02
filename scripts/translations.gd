extends Node
class_name Translations

var translations = {
	"en_US": {
		"intro.title": "OffSec Installation Wizard",
		"intro.continue": "Continue",
		"intro.translations_desc": "This is the language in which the game will be installed with.",
		"intro.username_desc": "The name you'll be called in the game.",
		"intro.priviledge_desc": "This parameters sets difficulty level.\nPermission level of the player in global system.\nRoot is equal to an admin,\nwhile User is a default system user.",
		"root": "Root",
		"user": "User",
		
		"player_room.text1": "Oh hey, you're alive, player.",
		"player_room.text2": "....what?",
		"player_room.text3": "I believe the installation wizard was malicious.\n It seems you are chosen to be the one to stop it.",
		"player_room.text4": "..wizard? what, how?",
		"player_room.text5": "Let's go outside, I'll explain everything in a second.",
		
		"outside.text1": "Okay so, it seems like.. YOU are in the game now.\nThe game installer was malicious, it intended to do it.",
		"outside.text2": "So what am I supposed to do?",
		"outside.text3": "We need to stop the installer. \nIt disguised itself as a local wizard, in this village.",
		"outside.text4": "How do we find him?",
		"outside.text5": "I don't know, let's find the local tavern.\nPeople there always have answers.",
		"outside.text6": "Oh BTW, I got you an FSH, a cool terminal tool.\nPress TAB anytime you like, and I'll explain everything.",
		
		"fsh.text1": "So, FSH is basically a programming language with cool utils.",
		"fsh.text2": "Let's start with math, it can do basic operations\nlike 2+2, 2*17, 0.5*0.5 etc. Try it!",
		"fsh.text3": "You can stack operations, like that:\na=15;b=a/5;b*3",
		"fsh.text4": "Next, there is a matterializator.\nYou see that lantern mouse over hanging on your roof?\nTry running $LanternMouse.move 30 0",
		"fsh.text5": "...",
		"fsh.text6": "Okay, that'll be all for now.\nUse it whenever you need.",
		"fsh.text7": "See ya in the Tavern!",

		"helpful_spirit": "Helpful Spirit",
		
		"task": "Task",
		
		"tasks.0": "Listen to the\nhelpful spirit.",
		"tasks.1": "Go outside.",
		"tasks.2": "Press TAB.",
		"tasks.3": "Find the\nTavern.",
		"tasks.4": "Find the\nWizard Location.",
		"tasks.5": "Find the\nWizard.",
		"tasks.6": "Kill the \nWizard.",
	},
	
	"pl_PL": {
		"intro.title": "Wizard Instalacji OffSec",
		"intro.continue": "Kontynuuj",
		"intro.translations_desc": "Język, z którym gra będzie zainstalowana.",
		"intro.username_desc": "Nazwa jakiej gra będzie używać względem ciebie.",
		"intro.priviledge_desc": "Ten parametr ustawia poziom trudności.\nRodzaj przywileji gracza w systemie globalnym.\nRoot jest równoznaczy z administratorem,\nUser zaś - z zwykłym użytkownikiem.",
		"root": "Root",
		"user": "Użytkownik",
	}
}


func by_key(language: String, key: String) -> String:
	return translations[language][key]
