extends Node2D

signal button_pressed(joke)

@export_enum("joke_button_1", "joke_button_2", "joke_button_3") var action: String
@export var sprite: Sprite2D

@export var stamina_categories: Array[int]
@export var type_sprites: Array[Texture2D]

var stamina_label: RichTextLabel

var current_joke: Joke

func _map_action_to_joke_type():
	match action:
		"joke_button_1":
			return Joke.JokeType.Joke1
		"joke_button_2":
			return Joke.JokeType.Joke2
		"joke_button_3":
			return Joke.JokeType.Joke3

func _get_joke(type):
	return Joke.get_random_joke(type)

func _ready():
	stamina_label = find_child("StaminaLabel")
	set_current_joke(_get_joke(_map_action_to_joke_type()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(action):
		button_pressed.emit(current_joke)
		set_current_joke(_get_joke(_map_action_to_joke_type()))

func set_current_joke(joke: Joke):
	current_joke = joke
	sprite.texture = type_sprites[joke.type]
	stamina_label.text = "%s" % joke.required_stamina
	print("stamina: ", joke.required_stamina)
