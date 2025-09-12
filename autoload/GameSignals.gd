extends Node
class_name Game_Signals

# Global signal hub
signal player_hit(damage: int)
signal enemy_killed(points: int)
signal spawn_request(kind: StringName, at: Vector2)
signal play_sfx(kind: StringName)
