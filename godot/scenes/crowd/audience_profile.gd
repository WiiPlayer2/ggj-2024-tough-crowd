class_name AudienceProfile
extends Node2D

const HAPPY_THRESHOLD: float = 2
const ANGRY_THRESHOLD: float = -1
const LASHOUT_THRESHOLD: float = -5
const HAPPINESS_DECAY: float = .01
const LASHOUT_DECAY: float = .01

const GOOD_REACTION: float = 1
const NEUTRAL_REACTION: float = .1
const BAD_REACTION: float = -1.2
const BOTTLE_REACTION: float = 3

class ProfileData:
	var happy_threshold: float
	var angry_threshold: float
	var lashout_threshold: float
	var happiness_decay: float
	var lashout_decay: float
	var joke_mood_mapping: Dictionary

	func _init(
		happy_threshold,
		angry_threshold,
		lashout_threshold,
		happiness_decay,
		lashout_decay,
		joke_mood_mapping
	):
		self.happy_threshold = happy_threshold
		self.angry_threshold = angry_threshold
		self.lashout_threshold = lashout_threshold
		self.happiness_decay = happiness_decay
		self.lashout_decay = lashout_decay
		self.joke_mood_mapping = joke_mood_mapping


var happy_threshold: float
var angry_threshold: float
var lashout_threshold: float

var happiness_decay: float
var lashout_decay: float

# Maps JokeType (as int) to mood change (as float)
var joke_mood_mapping: Dictionary


static func get_profile_data(index) -> ProfileData:
	var profiles = [
		ProfileData.new(HAPPY_THRESHOLD, ANGRY_THRESHOLD, LASHOUT_THRESHOLD, HAPPINESS_DECAY, LASHOUT_DECAY, {0: GOOD_REACTION, 1: BAD_REACTION, 2: NEUTRAL_REACTION, 3: BOTTLE_REACTION}),
		ProfileData.new(HAPPY_THRESHOLD, ANGRY_THRESHOLD, LASHOUT_THRESHOLD, HAPPINESS_DECAY, LASHOUT_DECAY, {0: NEUTRAL_REACTION, 1: GOOD_REACTION, 2: BAD_REACTION, 3: BOTTLE_REACTION}),
		ProfileData.new(HAPPY_THRESHOLD, ANGRY_THRESHOLD, LASHOUT_THRESHOLD, HAPPINESS_DECAY, LASHOUT_DECAY, {0: BAD_REACTION, 1: NEUTRAL_REACTION, 2: GOOD_REACTION, 3: BOTTLE_REACTION}),
	]
	return profiles[index]

func load_data(data: ProfileData):
	happy_threshold = data.happy_threshold
	angry_threshold = data.angry_threshold
	lashout_threshold = data.lashout_threshold
	happiness_decay = data.happiness_decay
	lashout_decay = data.lashout_decay
	joke_mood_mapping = data.joke_mood_mapping
