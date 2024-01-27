class_name AudienceMember
extends Sprite2D

@export var mood : float = 0.

@export var head : Node2D
@export var face : Node2D
@export var profile : AudienceProfile

@export_enum("angry", "neutral", "happy", "laugh") var expression

var known_faces : Array[String] = [
	"res://scenes/faces/face_curly.tscn",
	"res://scenes/faces/face_jenny.tscn",
	"res://scenes/faces/face_moritz.tscn",
	"res://scenes/faces/face_ronald.tscn",
	# Add more scenes as needed
]

const laughter_duration : float = 2. # seconds
const laughter_bobs : int = 4
var laughter_left : float = 0.

# Called when the node enters the scene tree for the first time.
func _ready():
	laughter_left = 0.
	mood = randf_range(profile.lashout_threshold, profile.happy_threshold)
	update_expression()
	
	if face == null:
		set_random_face()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if laughter_left >= 0:
		laughter_left -= delta
	
	if mood > profile.happy_threshold * .5:
		mood -= profile.happiness_decay * delta
	elif mood < profile.lashout_threshold * .9:
		mood += profile.lashout_decay * delta
		
	if Input.is_key_pressed(KEY_SPACE) and OS.is_debug_build():
		update_mood(1.)
		
	update_expression()

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

func set_random_face():
	var face_res = load(known_faces[randi() % known_faces.size()])
	face = face_res.instantiate()
	head.add_child(face)

func on_joke(joke: Joke):
	var mood_change = profile.joke_mood_mapping.get(joke.type, 0)
	update_mood(mood_change)
