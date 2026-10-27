class_name LevelSetting

extends Resource

@export var rows: int = 2
@export var columns: int = 2

var total_tiles: int:
	get: return rows * columns
	
var target_pairs: int:
	get: return total_tiles / 2


func _to_string() -> String:
	return "%dx%d" % [rows, columns]
