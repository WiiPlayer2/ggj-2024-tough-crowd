extends Node2D

signal button_pressed(joke)

@export_enum("joke_button_1", "joke_button_2", "joke_button_3") var action: String

var current_joke: Joke

func _init():
	current_joke = Joke.new(Joke.JokeType.Joke1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(action):
		button_pressed.emit(current_joke)
