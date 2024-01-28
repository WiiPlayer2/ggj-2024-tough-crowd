extends Label

@onready var crowd_controller: Crowd = get_node("/root/IngameScene/Crowd")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(int(crowd_controller.overall_mood))
