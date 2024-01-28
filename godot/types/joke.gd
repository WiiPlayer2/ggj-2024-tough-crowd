class_name Joke

enum JokeType {
	Joke1 = 0,
	Joke2,
	Joke3,
	Bottle,
}

var type: JokeType
var required_stamina: int

static func get_bottle_joke():
	return Joke.new(JokeType.Bottle, 0)

func _init(type, required_stamina):
	self.type = type
	self.required_stamina = required_stamina
