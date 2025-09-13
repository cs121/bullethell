extends Node2D
class_name LevelEditor

@export var tilemap_path: NodePath
@export var level_save_path: String = "res://levels/custom_level.tscn"
@onready var tilemap: TileMap = get_node(tilemap_path)

var current_tile: int = 0

func _ready() -> void:
	# Ensure tilemap exists before editing
	if !is_instance_valid(tilemap):
		push_error("TileMap not found: %s" % tilemap_path)

func _unhandled_input(event: InputEvent) -> void:
	# Paint or erase tiles based on mouse input
	if event is InputEventMouseButton and event.pressed:
		var local_pos := tilemap.to_local(get_global_mouse_position())
		var cell := tilemap.local_to_map(local_pos)
		if event.button_index == MouseButton.LEFT:
			# Place selected tile
			tilemap.set_cell(0, cell, current_tile)
		elif event.button_index == MouseButton.RIGHT:
			# Erase tile
			tilemap.set_cell(0, cell, -1)

func save_level() -> void:
	# Save current level to disk
	var packed := PackedScene.new()
	if packed.pack(self) == OK:
		var res := ResourceSaver.save(level_save_path, packed)
		if res != OK:
			push_error("Failed to save level: %s" % level_save_path)
	else:
		push_error("Failed to pack scene for saving")
