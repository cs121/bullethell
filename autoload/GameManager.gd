extends Node
class_name GameManager

@export var starting_lives: int = 3
var lives: int = 0

func new_game() -> void:
	# Initialize lives and load the first level
	lives = starting_lives
	_start_level()

func on_player_death() -> void:
	# Remove one life and decide the next scene
	lives -= 1
	if lives > 0:
		_start_level()
	else:
		get_tree().change_scene_to_file("res://ui/TitleScreen.tscn")

func _start_level() -> void:
	# Load the sample level scene
	get_tree().change_scene_to_file("res://main.tscn")
