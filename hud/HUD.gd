extends CanvasLayer
class_name HUD

@onready var health_label: Label = $HealthLabel

func update_health(value: int) -> void:
	health_label.text = "Health: %d" % value
