extends Node

signal level_pressed(level_setting: LevelSetting)
signal mem_butt_pressed(texture: Texture2D)
signal pair_found
signal pair_not_found
signal exit_pressed

func change_level(level_setting: LevelSetting) -> void:
	level_pressed.emit(level_setting)

func flip_tile(texture: Texture2D) -> void:
	mem_butt_pressed.emit(texture)

func successful_pair() -> void:
	pair_found.emit()

func unsuccessful_pair() -> void:
	pair_not_found.emit()

func exit_level() -> void:
	exit_pressed.emit()
