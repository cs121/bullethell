extends Control
class_name TitleScreen

@onready var start_button: Button = $StartButton
@onready var editor_button: Button = $EditorButton

func _ready() -> void:
	# Connect buttons to launch game or editor
	start_button.pressed.connect(_on_start_pressed)
	editor_button.pressed.connect(_on_editor_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_editor_pressed() -> void:
	# Load the level editor scene
	get_tree().change_scene_to_file("res://levels/LevelEditor.tscn")
