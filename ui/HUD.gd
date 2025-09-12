extends CanvasLayer
class_name HUD

@export var lives: int = 3
var score: int = 0
@export var flash_duration: float = 0.3
@export var flash_max_alpha: float = 0.4
var flash_time: float = 0.0
@export var extra_life_score: int = 100000
var next_life_score: int = extra_life_score

@onready var player: Player = get_parent().get_node("Player")

@onready var score_label: Label = $Score
@onready var lives_label: Label = $Lives
@onready var flash_rect: ColorRect = $Flash
@onready var level_name_label: Label = $LevelName

func _ready() -> void:
	_update()
	GameSignals.player_hit.connect(_on_player_hit)
	GameSignals.enemy_killed.connect(_on_enemy_killed)
	GameSignals.star_collected.connect(_on_star_collected)

func set_level_name(name: String) -> void:
	level_name_label.text = name

func _process(delta: float) -> void:
	if flash_time > 0.0:
		flash_time -= delta
		flash_rect.modulate.a = flash_max_alpha * (flash_time / flash_duration)
	else:
		flash_rect.modulate.a = 0.0

func _on_player_hit(damage: int) -> void:
	lives -= damage
	_update()

func _on_enemy_killed(points: int) -> void:
	score += points
	_check_extra_life()
	_update()

func _on_star_collected(points: int, at: Vector2) -> void:
	score += points
	_check_extra_life()
	flash_time = flash_duration
	flash_rect.modulate.a = flash_max_alpha
	_update()

func _check_extra_life() -> void:
	# Grant extra lives for reaching score thresholds
	while score >= next_life_score:
		lives += 1
		if is_instance_valid(player):
			player.lives += 1
		next_life_score += extra_life_score

func _update() -> void:
	score_label.text = str(score)
	lives_label.text = str(lives)
