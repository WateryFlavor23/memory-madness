extends Control


@onready var boxes: GridContainer = %Boxes
@onready var moves_number_label: Label = %MovesNumberLabel
@onready var pairs_number_label: Label = %PairsNumberLabel
@onready var game_over_container: MarginContainer = %GameOverContainer
@onready var game_over_music: AudioStreamPlayer = %GameOverMusic


const MEMORY_BUTTON = preload("uid://wxidmffuhjyh")
var _target_pairs: int = 0

func _ready() -> void:
	SignalHub.level_pressed.connect(prepare_level)
	SignalHub.pair_found.connect(update_pairs)
	SignalHub.pair_not_found.connect(update_attempts)

func prepare_level(level_setting: LevelSetting) -> void:
	# loads in new set of shuffled image pairs
	var lds: LevelDataSelector = LevelDataSelector.new()
	var selected_images: Array[Texture2D] = lds.get_images_for_level(level_setting)
	var selected_frame: Texture2D = ImageManager.get_random_frame_image()
	boxes.columns = level_setting.columns
	
	# for instantiating proper number of MemoryButtons
	for i in range(level_setting.total_tiles):
		var new_box = MEMORY_BUTTON.instantiate()
		boxes.add_child(new_box)
	
	_target_pairs = level_setting.target_pairs
	moves_number_label.text = str(ScoreManager.attempts)
	pairs_number_label.text = "0/%d" %  level_setting.target_pairs
	
	# for applying different images to TextureRect of each MemoryButton
	var memory_tiles = get_tree().get_nodes_in_group(MemoryButton.GROUP_NAME)
	for i in range(level_setting.total_tiles):
		var change_frm: TextureRect = memory_tiles[i].get_child(0)
		var change_img: TextureRect = memory_tiles[i].get_child(1)
		
		change_frm.texture = selected_frame
		change_img.texture = selected_images[i]

func update_pairs() -> void:
	update_attempts()
	ScoreManager.pairs += 1
	pairs_number_label.text = "%d/%d" % [ScoreManager.pairs, _target_pairs]
	
	if ScoreManager.pairs == _target_pairs:
		game_over_container.show()
		var game_over_score: Label = game_over_container.get_child(0).get_child(0).get_child(1)
		
		game_over_score.text = "In %d Attempts" % ScoreManager.attempts
		game_over_music.play()

func update_attempts() -> void:
	ScoreManager.attempts += 1
	moves_number_label.text = str(ScoreManager.attempts)

func _on_exit_button_pressed() -> void:
	var memory_tiles = get_tree().get_nodes_in_group(MemoryButton.GROUP_NAME)
	for tile in memory_tiles:
		tile.queue_free()
	
	# note: Should just use "boxes.get_children()"
	# less need for GROUPING code, unless needed in other places
	
	game_over_container.hide()
	SignalHub.exit_level()
