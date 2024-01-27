class_name AudienceProfile
extends Node2D

class ProfileData:
	var happy_threshold: float
	var angry_threshold: float
	var lashout_threshold: float
	var happiness_decay: float
	var lashout_decay: float
	var joke_mood_mapping: Dictionary

	func _init(happy_threshold, angry_threshold, lashout_threshold, happiness_decay, lashout_decay, joke_mood_mapping):
		self.happy_threshold = happy_threshold
		self.angry_threshold = angry_threshold
		self.lashout_threshold = lashout_threshold
		self.happiness_decay = happiness_decay
		self.lashout_decay = lashout_decay
		self.joke_mood_mapping = joke_mood_mapping

@export var happy_threshold : float
@export var angry_threshold : float
@export var lashout_threshold : float

@export var happiness_decay : float
@export var lashout_decay : float

# Maps JokeType (as int) to mood change (as float)
@export var joke_mood_mapping: Dictionary

static func get_profile_data(index) -> ProfileData:
	var profiles = [
		ProfileData.new(3, -3, -10, 1, 10, { 0: 1, 1: 0, 2: -0.5 }),
		ProfileData.new(3, -3, -10, 1, 10, { 0: -0.5, 1: 1, 2: 0 }),
		ProfileData.new(3, -3, -10, 1, 10, { 0: 0, 1: -0.5, 2: 1 }),
	]
	return profiles[index]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func load_data(data: ProfileData):
	happy_threshold = data.happy_threshold
	angry_threshold = data.angry_threshold
	lashout_threshold = data.lashout_threshold
	happiness_decay = data.happiness_decay
	lashout_decay = data.lashout_decay
	joke_mood_mapping = data.joke_mood_mapping
