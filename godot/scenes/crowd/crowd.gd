class_name Crowd
extends Node2D

@export_range(1, 16, 1) var max_persons = 16

var audience: Array[AudienceMember] = []
var overall_mood: float = 0


func _ready():
	var counter = 0
	var person = preload("res://scenes/crowd/person.tscn")
	for seat in $Seats.get_children():
		var person_node = person.instantiate()
		person_node.color = AudienceMember.get_random_color()
		seat.add_child(person_node)
		audience.append(person_node)

		counter += 1
		if counter == max_persons:
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	overall_mood = 0
	for m in audience:
		overall_mood += m.mood * 10
