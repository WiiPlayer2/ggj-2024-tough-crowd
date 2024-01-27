extends Node2D

signal button_pressed(joke)

@export_enum("joke_button_1", "joke_button_2", "joke_button_3") var action: String
@export var sprite: Sprite2D

@export var type_sprites: Array[Texture2D]

var current_joke: Joke

func _map_action_to_joke():
	match action:
		"joke_button_1":
			return Joke.new(Joke.JokeType.Joke1)
		"joke_button_2":
			return Joke.new(Joke.JokeType.Joke2)
		"joke_button_3":
			return Joke.new(Joke.JokeType.Joke3)

func _ready():
	set_current_joke(_map_action_to_joke())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(action):
		button_pressed.emit(current_joke)

func set_current_joke(joke: Joke):
	current_joke = joke
	sprite.texture = type_sprites[joke.type]
