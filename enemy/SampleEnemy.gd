extends Enemy
class_name SampleEnemy

@export var start_pattern: StringName = &"PatternFan"

func _ready() -> void:
	# Activate with default pattern
	activate(position, start_pattern)
