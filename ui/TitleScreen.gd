extends Control
class_name TitleScreen

@onready var start_button: Button = $StartButton

func _ready() -> void:
	# Connect start button to launch new game
	start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
