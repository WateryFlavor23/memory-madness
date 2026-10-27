extends TextureButton


@onready var level_label: Label = %LevelLabel
@export var level_setting: LevelSetting


func _ready() -> void:
	level_label.text = str(level_setting)

func _on_pressed() -> void:
	SignalHub.change_level(level_setting)
