extends Control


@onready var main: Control = %Main
@onready var game: Control = %Game

func _ready() -> void:
	SignalHub.level_pressed.connect(change_level)
	SignalHub.exit_pressed.connect(return_main)

func change_level(_level_setting: LevelSetting) -> void:
	main.hide()
	game.show()

func return_main() -> void:
	game.hide()
	main.show()
