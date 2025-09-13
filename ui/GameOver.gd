extends Control
class_name GameOver

@onready var continue_button: Button = $CenterContainer/VBoxContainer/ContinueButton

func _ready() -> void:
	# Allow processing even when the tree is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	continue_button.pressed.connect(_on_continue_pressed)

func show_game_over() -> void:
	# Display game over screen and pause the game
	visible = true
	get_tree().paused = true

func _on_continue_pressed() -> void:
	# Resume the game and restart the main scene
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main.tscn")
