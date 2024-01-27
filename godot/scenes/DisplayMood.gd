extends Label

var audience : Array[AudienceMember] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for seat in get_node("/root/IngameScene/Crowd/Seats").get_children():
		audience.append(seat.get_node("Person"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mood = 0
	for m in audience:
		mood += m.mood
	text = str(int(mood))
