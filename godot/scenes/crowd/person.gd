extends Sprite2D

@export var head : Node2D
@export var face : Node2D

var known_faces : Array[String] = [
	"res://scenes/faces/face_curly.tscn",
	"res://scenes/faces/face_moritz.tscn",
	"res://scenes/faces/face_ronald.tscn",
	# Add more scenes as needed
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if face == null:
		set_random_face()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_random_face():
	var face_res = load(known_faces[randi() % known_faces.size()])
	face = face_res.instantiate()
	head.add_child(face)
