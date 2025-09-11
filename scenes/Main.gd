extends Node2D
class_name Main

@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var projectile_pool: ObjectPool = $ProjectilePool
@onready var enemy_pool: ObjectPool = $EnemyPool
@onready var effect_pool: ObjectPool = $EffectPool

func _ready() -> void:
	GameManager.initialize(enemy_pool, projectile_pool, effect_pool)
	var health_comp: HealthComponent = player.get_node("HealthComponent")
	health_comp.health_changed.connect(hud.update_health)
	health_comp.died.connect(_on_player_died)
	hud.update_health(health_comp.current_health)
	GameManager.start_mission("res://missions/mission1.json")

func _on_player_died() -> void:
	get_tree().reload_current_scene()
