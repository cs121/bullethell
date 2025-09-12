extends Area2D
class_name Star

@export var value: int = 100
@export var fall_speed: float = 30.0

func drop(at: Vector2) -> void:
	# Activate star at given position
	position = at
	Utils.activate(self)
	update()

func _physics_process(delta: float) -> void:
	# Fall slowly downward
	position.y += fall_speed * delta

func _draw() -> void:
	# Draw a simple yellow star
	var pts: Array[Vector2] = []
	for i in 10:
		var angle := TAU * i / 10 - PI / 2
		var r := 8.0 if i % 2 == 0 else 3.0
		pts.append(Vector2(cos(angle), sin(angle)) * r)
	draw_polygon(PackedVector2Array(pts), PackedColorArray([Color.YELLOW]))

func _on_body_entered(body: Node) -> void:
	if body is Player:
		GameSignals.play_sfx.emit(&"collect")
		GameSignals.star_collected.emit(value, global_position)
		GameSignals.spawn_request.emit(&"score_text", global_position)
		PoolManager.return_to_pool(self)
