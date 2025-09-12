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
	match kind:
		&"hit_fx":
			var fx := PoolManager.get_from_pool(&"hit_fx") as HitSpark
			add_child(fx)
			fx.show_at(at)
		&"star":
			var s := PoolManager.get_from_pool(&"stars") as Star
			add_child(s)
			s.drop(at)
		&"score_text":
			var t := PoolManager.get_from_pool(&"score_text") as ScorePopup
			add_child(t)
			t.show_at(at, "+100")
