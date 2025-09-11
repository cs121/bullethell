extends Node
class_name WeaponComponent

@export var fire_rate: float = 0.2
@export var projectile_pool_path: NodePath
@export var sound_shoot: AudioStream?
@export var direction: Vector2 = Vector2.UP

var cooldown: float = 0.0
var projectile_pool: ObjectPool

func _ready() -> void:
	if projectile_pool_path != NodePath():
		projectile_pool = get_node(projectile_pool_path)

func _process(delta: float) -> void:
	if cooldown > 0.0:
		cooldown -= delta

func shoot(origin: Vector2) -> void:
	if cooldown > 0.0:
		return
	if projectile_pool == null:
		return
	var projectile := projectile_pool.get_instance() as Node2D
	if projectile == null:
		return
	if projectile.has_method("activate"):
		projectile.activate(origin, direction, projectile_pool)
	cooldown = fire_rate
	if sound_shoot:
		AudioManager.play_sfx(sound_shoot, origin)
