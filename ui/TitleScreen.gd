extends Control
class_name TitleScreen

@onready var new_game_button: Button = $NewGameButton
@onready var editor_button: Button = $EditorButton
@onready var exit_button: Button = $ExitButton

func _ready() -> void:
	# Connect buttons to launch game, editor or quit
	new_game_button.pressed.connect(_on_new_game_pressed)
	editor_button.pressed.connect(_on_editor_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_new_game_pressed() -> void:
	GameManager.new_game()

func _on_editor_pressed() -> void:
	# Load the level editor scene
	get_tree().change_scene_to_file("res://levels/LevelEditor.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
