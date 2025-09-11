extends Node
class_name PatternBase

var active: bool = false

func set_active(a: bool) -> void:
	active = a

func setup(enemy: Node, params: Dictionary) -> void:
	pass

func tick(enemy: Node, delta: float) -> void:
	pass
