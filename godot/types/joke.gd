class_name Joke

enum JokeType {
	Joke1,
	Joke2,
	Joke3
}

var type: JokeType

func _init(type):
	self.type = type
