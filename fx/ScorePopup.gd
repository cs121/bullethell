extends Node2D
class_name ScorePopup

@export var duration: float = 0.6
var time: float = 0.0
@onready var label: Label = $Label

func show_at(pos: Vector2, text: String) -> void:
	# Display text at world position
	position = pos
	label.text = text
	time = duration
	Utils.activate(self)

func _process(delta: float) -> void:
	if time <= 0.0:
		return
	time -= delta
	position.y -= 20.0 * delta
	if time <= 0.0:
		PoolManager.return_to_pool(self)
