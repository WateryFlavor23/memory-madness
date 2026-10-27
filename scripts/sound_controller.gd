extends Node


@onready var main_music: AudioStreamPlayer = %MainMusic
@onready var game_music: AudioStreamPlayer = %GameMusic
@onready var impact_1: AudioStreamPlayer = %Impact1
@onready var impact_2: AudioStreamPlayer = %Impact2
@onready var pair: AudioStreamPlayer = %Pair

var _impact_flag: bool = true

func _ready() -> void:
	play_main_music()
	
	SignalHub.exit_pressed.connect(play_main_music)
	SignalHub.level_pressed.connect(play_game_music)
	SignalHub.mem_butt_pressed.connect(play_impact)
	SignalHub.pair_found.connect(play_pair)

func play_main_music() -> void:
	game_music.stop()
	main_music.play()

func play_game_music(_level_setting: LevelSetting) -> void:
	main_music.stop()
	game_music.play()
	
func play_impact(_texture: Texture2D) -> void:
	if _impact_flag:
		impact_1.play()
		_impact_flag = false
	else:
		impact_2.play()
		_impact_flag = true

func play_pair() -> void:
	pair.play()
