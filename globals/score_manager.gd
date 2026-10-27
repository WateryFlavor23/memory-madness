extends Node

var attempts: int = 0
var pairs: int = 0
var _button_1: Texture2D = null
var _button_2: Texture2D = null

func _ready() -> void:
	SignalHub.mem_butt_pressed.connect(on_flip)
	SignalHub.exit_pressed.connect(reset_scores)
	SignalHub.exit_pressed.connect(reset_buttons)

func on_flip(texture: Texture2D) -> void:
	if !_button_1: _button_1 = texture
	else: 
		_button_2 = texture
		
		if _button_1 == _button_2: 
			print("PAIR FOUND!!")
			SignalHub.successful_pair()
		else: 
			print("pair not found :<")
			SignalHub.unsuccessful_pair()
		
		reset_buttons()

func reset_scores() -> void:
	attempts = 0
	pairs = 0

func reset_buttons() -> void:
	_button_1 = null
	_button_2 = null
