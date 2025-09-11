extends CanvasLayer
class_name HUD

@export var lives: int = 3
var score: int = 0

@onready var score_label: Label = $Score
@onready var lives_label: Label = $Lives

func _ready() -> void:
	_update()
	GameSignals.player_hit.connect(_on_player_hit)
	GameSignals.enemy_killed.connect(_on_enemy_killed)

func _on_player_hit(damage: int) -> void:
	lives -= damage
	_update()

func _on_enemy_killed(points: int) -> void:
	score += points
	_update()

func _update() -> void:
	score_label.text = str(score)
	lives_label.text = str(lives)
