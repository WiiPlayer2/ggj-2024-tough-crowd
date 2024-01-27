extends CenterContainer

signal game_exited

@onready var new_game_button := %NewGameButton
@onready var exit_button := %ExitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game_button.pressed.connect(_new_game)
	exit_button.pressed.connect(_exit)

func grab_button_focus() -> void:
	new_game_button.grab_focus()

func _new_game() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ingame_scene.tscn")

func _exit() -> void:
	game_exited.emit()
	get_tree().quit()

