class_name Joke

enum JokeType {
	Joke1 = 0,
	Joke2,
	Joke3
}

var type: JokeType
var required_stamina: int

func _init(type, required_stamina):
	self.type = type
	self.required_stamina = required_stamina
