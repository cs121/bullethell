extends Node
class_name MovementComponent

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2.ZERO

func set_input(dir: Vector2) -> void:
	direction = dir

func get_velocity() -> Vector2:
	return direction.normalized() * speed
