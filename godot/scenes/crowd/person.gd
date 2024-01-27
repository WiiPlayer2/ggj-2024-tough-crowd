extends Sprite2D

@export var head : Node2D
@export var face : Node2D
@export var mood : float = 0.0

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
    if mood < -9.9:
        throw_bottle()

func set_random_face():
    var face_res = load(known_faces[randi() % known_faces.size()])
    face = face_res.instantiate()
    head.add_child(face)

func throw_bottle():
    mood += 2.0

    var bottle_scene = preload("res://scenes/objects/bottle.tscn")
    var bottle = bottle_scene.instantiate()

    add_child(bottle);


func _on_debug_timer_timeout():
    mood -= 1
