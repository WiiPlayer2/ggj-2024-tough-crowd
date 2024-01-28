class_name AudienceMember
extends Node2D

@export var mood : float = 0.
@export_enum("blue", "green", "red") var color

@export var head : Node2D
@export var face : Node2D
@export var body : Node2D
@export var body_shape : Node2D
@export var profile : AudienceProfile

@export_enum("angry", "neutral", "happy", "laugh") var expression

var is_listening : bool = false
var last_joke_heard : Joke.JokeType = -1

var known_faces : Array[String] = [
	"res://scenes/faces/face_curly.tscn",
	"res://scenes/faces/face_jenny.tscn",
	"res://scenes/faces/face_moritz.tscn",
	"res://scenes/faces/face_ronald.tscn",
	# Add more scenes as needed
]

var known_bodies = {
	"blue" : [
		"res://scenes/bodies/body_blue_1.tscn",
		"res://scenes/bodies/body_blue_2.tscn",
		"res://scenes/bodies/body_blue_3.tscn",
		# Add more scenes as needed
	],
	"green" : [
		"res://scenes/bodies/body_green_1.tscn",
		"res://scenes/bodies/body_green_2.tscn",
		"res://scenes/bodies/body_green_3.tscn",
		# Add more scenes as needed
	],
	"red" : [
		"res://scenes/bodies/body_red_1.tscn",
		"res://scenes/bodies/body_red_2.tscn",
		"res://scenes/bodies/body_red_3.tscn",
		# Add more scenes as needed
	],
}

const laughter_duration : float = 2. # seconds
const laughter_bobs : int = 4
var laughter_left : float = 0.

func _map_color_to_profile_data_index(color):
	match color:
		"green":
			return 0
		"blue":
			return 1
		"red":
			return 2
	return 0

static func get_random_color():
	var keys = ["blue", "green", "red"]
	return keys[randi() % keys.size()]

# Called when the node enters the scene tree for the first time.
func _ready():
	laughter_left = 0.
	mood = randf_range(profile.lashout_threshold, profile.happy_threshold)
	update_expression()

	var profile_index = _map_color_to_profile_data_index(color)
	var profile_data = AudienceProfile.get_profile_data(profile_index)
	profile.load_data(profile_data)

	if body_shape == null:
		set_random_body(color)

	if face == null:
		set_random_face()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if laughter_left >= 0:
		laughter_left -= delta

	if not is_listening and mood > profile.happy_threshold * .5:
		mood -= profile.happiness_decay * delta
	elif not is_listening and mood < profile.lashout_threshold * .9:
		mood += profile.lashout_decay * delta


	if mood < profile.lashout_threshold:
		throw_bottle()

	update_expression()

func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if just_pressed and OS.is_debug_build():
		if Input.is_key_pressed(KEY_SPACE):
			update_mood(1.)
		elif Input.is_key_pressed(KEY_ENTER):
			update_mood(-1.)

func update_mood(change: float):
	if mood > profile.happy_threshold and change > 0 and laughter_left <= 0:
		laughter_left = laughter_duration
		# bob head
		var tween = get_tree().create_tween().bind_node(self).set_loops(laughter_bobs)
		var bob_duration = laughter_duration / laughter_bobs / 2
		tween.tween_property(face, "position", Vector2.UP * 20, bob_duration).set_delay(randf_range(0, bob_duration))
		tween.tween_property(face, "position", Vector2.ZERO, bob_duration)

	mood += change

func update_expression():
	if laughter_left > 0:
		expression = "laugh"
	elif mood > profile.happy_threshold:
		expression = "happy"
	elif mood < profile.angry_threshold:
		expression = "angry"
	else:
		expression = "neutral"

func set_random_body(for_color):
	if str(for_color) not in known_bodies:
		var keys = known_bodies.keys()
		for_color = keys[randi() % keys.size()]
		print(keys.size())
	var body_path = known_bodies[for_color][randi() % known_bodies[for_color].size()]
	var body_res = load(body_path)
	body_shape = body_res.instantiate()
	body.add_child(body_shape)

func set_random_face():
	var face_res = load(known_faces[randi() % known_faces.size()])
	face = face_res.instantiate()
	head.add_child(face)

func on_joke_start():
	is_listening = true

func on_hear_joke(joke: Joke):
	var mood_change = profile.joke_mood_mapping.get(joke.type, 0)
	if joke.type == last_joke_heard:
		mood_change = min(0, mood_change)
	update_mood(mood_change)
	last_joke_heard = joke.type

func on_joke_finish():
	is_listening = false

func throw_bottle():
	mood += 2.0

	var bottle_scene = preload("res://scenes/objects/bottle.tscn")
	var bottle = bottle_scene.instantiate()

	add_child(bottle);
