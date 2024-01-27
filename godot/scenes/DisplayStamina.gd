extends Label

@onready var Tim : Comedian = get_node("../../Tim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(int(max(0, Tim.stamina)))
