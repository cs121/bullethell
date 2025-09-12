extends Node
class_name Sound_Pool

@export var pool_size: int = 16
@export var sfx_shoot: AudioStream = preload("res://assets/sfx/shoot.wav")
@export var sfx_explosion: AudioStream = preload("res://assets/sfx/explosion.wav")

var players: Array[AudioStreamPlayer] = []
var index: int = 0

func _ready() -> void:
	for i in pool_size:
		var p := AudioStreamPlayer.new()
		p.bus = &"SFX"
		add_child(p)
		players.append(p)
	GameSignals.play_sfx.connect(_on_play_sfx)

func play(stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0, bus: StringName = &"SFX") -> void:
	var p := players[index]
	index = (index + 1) % players.size()
	p.stream = stream
	p.volume_db = volume_db
	p.pitch_scale = pitch_scale
	p.bus = bus
	p.play()

func _on_play_sfx(kind: StringName) -> void:
	match kind:
		&"shoot":
			play(sfx_shoot)
		&"explosion":
			play(sfx_explosion)
		&"collect":
			play(sfx_shoot)
