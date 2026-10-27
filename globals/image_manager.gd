extends Node


const TILE_IMAGES: TileImagesHolder = preload("uid://c38m3tpl6iqhq")
const FRAME_IMAGES: Array[Texture2D] = [
	preload("uid://xku535x6lyse"),
	preload("uid://bd41objtmfeaq"),
	preload("uid://gi84o5w5wm0m"),
	preload("uid://c3w7yuxoy4p32")
]

func get_random_image() -> Texture2D:
	return TILE_IMAGES.tile_images.pick_random()

func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()

func shuffle_images() -> void:
	TILE_IMAGES.tile_images.shuffle()

func get_image_at_idx(idx: int) -> Texture2D:
	if idx > TILE_IMAGES.tile_images.size() or idx < 0:
		printerr("TILE_IMAGE idx out of bounds.")
	return TILE_IMAGES.tile_images[idx]
