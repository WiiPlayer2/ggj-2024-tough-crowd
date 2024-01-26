extends Node2D

@export var mood : int = 0
var last_mood : int = 0

@export var sprite_happy : Sprite2D
@export var sprite_neutral : Sprite2D
@export var sprite_unhappy : Sprite2D

const tween_speed : float = 1.5
const color_transparent : Color = Color(1, 1, 1, 0)
const color_visible : Color = Color(1, 1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	mood = 0
	last_mood = 0
	sprite_happy.modulate.a = 0
	sprite_neutral.modulate.a = 1
	sprite_unhappy.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if mood != last_mood:
		var tween = get_tree().create_tween().bind_node(self).set_parallel().set_trans(Tween.TRANS_LINEAR)
		if mood < 0:
			tween.tween_property(sprite_unhappy, "modulate", color_visible, tween_speed)
			tween.tween_property(sprite_neutral, "modulate", color_transparent, tween_speed)
			tween.tween_property(sprite_happy, "modulate", color_transparent, tween_speed)
		elif mood > 0:
			tween.tween_property(sprite_unhappy, "modulate", color_transparent, tween_speed)
			tween.tween_property(sprite_neutral, "modulate", color_transparent, tween_speed)
			tween.tween_property(sprite_happy, "modulate", color_visible, tween_speed)
		else:
			tween.tween_property(sprite_unhappy, "modulate", color_transparent, tween_speed)
			tween.tween_property(sprite_neutral, "modulate", color_visible, tween_speed)
			tween.tween_property(sprite_happy, "modulate", color_transparent, tween_speed)
		last_mood = mood
