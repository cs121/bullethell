extends Node2D
class_name LevelController

@export var scroll_speed: float = 40.0
@onready var spawner: Spawner = $Spawner
@onready var hud: HUD = $HUD
@onready var bg: TileMap = $BG

func _ready() -> void:
	GameSignals.spawn_request.connect(_on_spawn_request)

func _process(delta: float) -> void:
	bg.position.y += scroll_speed * delta

func _on_spawn_request(kind: StringName, at: Vector2) -> void:
	if kind == &"hit_fx":
		var fx := PoolManager.get_from_pool(&"hit_fx") as HitSpark
		add_child(fx)
		fx.show_at(at)
