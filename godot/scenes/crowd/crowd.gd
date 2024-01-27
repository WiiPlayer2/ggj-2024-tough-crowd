extends Node2D

@export_range(1, 16, 1)
var max_persons = 16

func _ready():
	var counter = 0
	var person = preload("res://scenes/crowd/person.tscn")
	for seat in $Seats.get_children():
		var person_node = person.instantiate()
		person_node.color = AudienceMember.get_random_color()
		seat.add_child(person_node)

		counter += 1
		if counter == max_persons:
			break
