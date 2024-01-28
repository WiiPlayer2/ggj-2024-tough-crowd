extends Node2D

@export var next_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func _input(event):
    if event.is_action_pressed("interact"):
        change_scene()

func _on_button_pressed():
    change_scene()

func change_scene():
    get_tree().change_scene_to_packed(next_scene)
