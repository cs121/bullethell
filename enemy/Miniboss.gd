extends Enemy
class_name Miniboss

@export var start_pattern: StringName = &"PatternSpiral"

func _ready() -> void:
	# Activate miniboss with given pattern
	activate(position, start_pattern)
