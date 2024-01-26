extends Node2D

@export var move_speed = 100
@export var boundary: Boundary

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		position += Vector2.RIGHT * delta * move_speed
		if position.x > boundary.get_most_right_position():
			position = Vector2(boundary.get_most_right_position(), position.y)
		
	if Input.is_action_pressed("move_left"):
		position += Vector2.LEFT * delta * move_speed
		if position.x < boundary.get_most_left_position():
			position = Vector2(boundary.get_most_left_position(), position.y)
