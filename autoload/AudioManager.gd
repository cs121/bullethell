extends Node
class_name AudioManager

@export var pool_size: int = 16

var available: Array[AudioStreamPlayer2D] = []
var in_use: Array[AudioStreamPlayer2D] = []

func _ready() -> void:
	for i in pool_size:
		var player := AudioStreamPlayer2D.new()
		player.finished.connect(_on_player_finished.bind(player))
		add_child(player)
		available.push_back(player)

func play_sfx(stream: AudioStream, position: Vector2) -> void:
	if available.is_empty():
		return
	var player := available.pop_back()
	in_use.push_back(player)
	player.stream = stream
	player.global_position = position
	player.play()

func _on_player_finished(player: AudioStreamPlayer2D) -> void:
	player.stop()
	in_use.erase(player)
	available.push_back(player)
