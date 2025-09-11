extends Node
class_name HealthComponent

signal died
signal health_changed(value: int)

@export var max_health: int = 3
var current_health: int

func _ready() -> void:
	current_health = max_health

func take_damage(amount: int) -> void:
	current_health -= amount
	health_changed.emit(current_health)
	if current_health <= 0:
		died.emit()

func reset() -> void:
	current_health = max_health
	health_changed.emit(current_health)
