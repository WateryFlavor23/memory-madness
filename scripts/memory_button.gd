class_name MemoryButton
extends TextureButton


@onready var frame_rect: TextureRect = %FrameRect
@onready var image_rect: TextureRect = %ImageRect
@onready var show_timer: Timer = %ShowTimer

const GROUP_NAME: String = "MemoryButtons"
var selected: bool = false
var found: bool = false


func _ready() -> void:
	SignalHub.pair_found.connect(freeze_button)
	SignalHub.pair_not_found.connect(hide_button)

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func freeze_button() -> void:
	# triggers when pair is found
	# should stop input from being accepted
	if selected: 
		selected = false
		z_index = 10
		found = true
		run_tween()

func hide_button() -> void:
	# SIGNAL
	# triggers when pair is not found
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	# starts a timer to let player see image
	show_timer.start()
	
func reveal(r: bool) -> void:
	frame_rect.visible = r
	image_rect.visible = r

func run_tween() -> void:
	var tween: Tween = create_tween()
	tween.parallel().tween_property(self, "scale", Vector2(1.2, 1.2), 0.3)
	tween.parallel().tween_property(self, "rotation", deg_to_rad(720), 0.3)
	tween.tween_property(self, "scale", Vector2(), 0.8)

func _on_pressed() -> void:
	reveal(true)
	selected = true
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE # stops player from inputting same tile
	SignalHub.flip_tile(image_rect.texture)

func _on_show_timer_timeout() -> void:
	if !found:
		mouse_filter = Control.MOUSE_FILTER_STOP
		selected = false
		reveal(false)
