extends TextureRect


func _ready() -> void:
	set_random_image()
	run_tween()

func set_random_image() -> void:
	texture = ImageManager.get_random_image()

func get_rand_spin_time() -> float:
	return randf_range(1.0, 2.0)

func get_rand_spin_rad() -> float:
	return deg_to_rad(randf_range(-360.0, 360.0))

func run_tween() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "rotation", get_rand_spin_rad(), get_rand_spin_time())
	tween.tween_property(self, "scale", Vector2(0.05, 0.05), 1.0)
	tween.tween_callback(set_random_image)
	tween.tween_property(self, "scale", Vector2(1, 1), 1.0)
	tween.tween_interval(0.1)
	tween.tween_callback(run_tween)
