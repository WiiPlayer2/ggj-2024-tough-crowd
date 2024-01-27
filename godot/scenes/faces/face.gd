extends Node2D

@export_enum("angry", "neutral", "happy", "laugh") var expression

var person_controller : AudienceMember
var expression_map = {}

const expression_change_speed : float = 1.5
const color_transparent : Color = Color(1, 1, 1, 0)
const color_visible : Color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	expression_map = {
		"angry" : $Unhappy,
		"neutral" : $Neutral,
		"happy" : $Happy,
		"laugh" : $Laugh,
	}
	person_controller = get_node("../../../Person")
	expression = person_controller.expression
	reset_face()
	
func _process(_delta):
	if expression != person_controller.expression:
		update_face(person_controller.expression)
		expression = person_controller.expression

func reset_face():
	for expr in expression_map:
		expression_map[expr].modulate = color_transparent.lerp(color_visible, expr == expression)

func update_face(new_expression: String):
	var tween = get_tree().create_tween().bind_node(self).set_parallel().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(expression_map[expression], "modulate", color_transparent, expression_change_speed)
	tween.tween_property(expression_map[new_expression], "modulate", color_visible, expression_change_speed)
