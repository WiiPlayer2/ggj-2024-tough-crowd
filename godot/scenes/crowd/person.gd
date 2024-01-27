class_name AudienceMember
extends Sprite2D

@export var mood : float = 0.

@export var head : Node2D
@export var face : Node2D
@export var profile : AudienceProfile

@export_enum("angry", "neutral", "happy", "laugh") var expression

var known_faces : Array[String] = [
	"res://scenes/faces/face_curly.tscn",
	"res://scenes/faces/face_moritz.tscn",
	"res://scenes/faces/face_ronald.tscn",
	# Add more scenes as needed
]

# Called when the node enters the scene tree for the first time.
func _ready():
	mood = randf_range(profile.lashout_threshold, profile.happy_threshold)
	update_expression()
	
	if face == null:
		set_random_face()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mood > profile.happy_threshold:
		mood = max(mood - profile.happiness_decay * delta, profile.happy_threshold)
	elif mood < profile.lashout_threshold:
		mood = min(mood + profile.lashout_decay * delta, profile.lashout_threshold)

func hear_joke():
	var change = randf_range(-3., 3.)
	update_mood(change)
	
func update_mood(change: float):
	if mood > profile.happy_threshold and change > 0:
		pass #toggle laugh
	mood += change
	update_expression()

func update_expression():
	if mood > profile.happy_threshold:
		expression = "happy"
	elif mood < profile.angry_threshold:
		expression = "angry"
	else:
		expression = "neutral"

func set_random_face():
	var face_res = load(known_faces[randi() % known_faces.size()])
	face = face_res.instantiate()
	head.add_child(face)
