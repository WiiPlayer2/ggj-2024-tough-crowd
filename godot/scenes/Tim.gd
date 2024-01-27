extends Node2D

@export var move_speed = 100
@export var boundary: Boundary
@export var tim_sprite : Sprite2D
@export var transmitter_area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		tim_sprite.flip_h = true
		global_position += Vector2.RIGHT * delta * move_speed
		if global_position.x > boundary.get_most_right_position():
			global_position = Vector2(boundary.get_most_right_position(), global_position.y)
		
	if Input.is_action_pressed("move_left"):
		tim_sprite.flip_h = false
		global_position += Vector2.LEFT * delta * move_speed
		if global_position.x < boundary.get_most_left_position():
			global_position = Vector2(boundary.get_most_left_position(), global_position.y)


func _on_joke_button_button_pressed(joke):
	for body in transmitter_area.get_overlapping_bodies():
		var person = body.find_parent("Person")
		if not (person is AudienceMember):
			continue
		
		person.on_joke(joke)
