class_name Joke

enum JokeType {
	Joke1 = 0,
	Joke2,
	Joke3,
	Bottle,
}

const EFFECTIVENESS_SCALING: float = 1
const STAMINA_CATEGORIES: Array[float] = [
	1,
	5,
	10,
]

var type: JokeType
var required_stamina: int
var effectiveness: float

static func get_bottle_joke():
	return Joke.new(JokeType.Bottle, 15, 1)

static func get_random_joke(type):
	var stamina = STAMINA_CATEGORIES[randi_range(0, STAMINA_CATEGORIES.size() - 1)]
	return Joke.new(type, stamina, stamina * EFFECTIVENESS_SCALING)

func _init(type, required_stamina, effectiveness):
	self.type = type
	self.required_stamina = required_stamina
	self.effectiveness = effectiveness
