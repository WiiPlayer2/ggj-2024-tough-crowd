class_name Comedian
extends Node2D

@export var move_speed = 100
@export var boundary: Boundary
@export var tim_sprite: Sprite2D
@export var transmitter_area: Area2D
@export var stamina: int = 100

var default_texture: Texture2D = load("res://sprites/tim_side.png")
var ducking_texture: Texture2D = load("res://sprites/tim_ducking.svg")


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.hit_tim.connect(ouch)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimationPlayer.is_playing():
		return

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

func _disable_buttons():
	$"Joke Buttons".hide()
	$"Joke Buttons".process_mode = Node.PROCESS_MODE_DISABLED

func _enable_buttons():
	$"Joke Buttons".show()
	$"Joke Buttons".process_mode = Node.PROCESS_MODE_INHERIT

func _on_joke_button_button_pressed(joke: Joke):
	$AnimationPlayer.play("talking")
	_disable_buttons()
	stamina -= joke.required_stamina

	for body in transmitter_area.get_overlapping_bodies():
		var person = body.find_parent("Person")
		if not (person is AudienceMember):
			continue

		person.on_joke(joke)

func _on_stamina_empty():
	get_node("../DisplayGUI").visible = false
	
	var fade = get_node("/root/IngameScene/UI/FadeOverlay")
	fade.modulate.a = fade.minimum_opacity
	fade.visible = true
	
	get_viewport().set_input_as_handled()
	get_tree().paused = true
	
	var score_overlay = get_node("/root/IngameScene/UI/ScoreOverlay")
	score_overlay.get_node("VBoxContainer3/FinalScore").text = str(int(get_node("/root/IngameScene/Crowd").overall_mood))
	score_overlay.grab_button_focus()
	score_overlay.visible = true
	pass

func ouch():
	$Sprite2D.texture = ducking_texture
	await get_tree().create_timer(1).timeout
	$Sprite2D.texture = default_texture

func _on_animation_player_animation_finished(anim_name):
	if stamina <= 0:
		_on_stamina_empty()
	else:
		_enable_buttons()
