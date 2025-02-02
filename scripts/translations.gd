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
