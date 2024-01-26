class_name Boundary
extends Node2D

@export var width = 200.

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_most_left_position():
	return global_position.x - width / 2
	
func get_most_right_position():
	return global_position.x + width / 2
