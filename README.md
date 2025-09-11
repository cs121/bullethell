# Bullet Hell Starter

Minimal Godot 4.4+ 2D bullet-hell prototype using object and sound pooling for performance and easy extensibility.

## Setup
1. Install [Godot 4.4](https://godotengine.org).  
2. Clone this repository and open `project.godot` in Godot.  
3. Ensure the following autoloads are present (already in `project.godot`):
   - `GameSignals` → `res://autoload/GameSignals.gd`
   - `PoolManager` → `res://core/PoolManager.gd`
   - `SoundPool` → `res://core/SoundPool.gd`
4. Import placeholder assets in `assets/` (replace with real sprites/sfx).
5. Input map actions (`move_*`, `shoot`, `focus`, `pause`) are configured in `project.godot`. Adjust in Project Settings > Input Map if needed.

## Running
Open the project and run the main scene (`main.tscn`). A basic level with player, enemy spawner and HUD will start.

## Extending
- **New Patterns**: create a script extending `PatternBase` in `enemy/patterns/` and add a node under `Enemy/Patterns` using that script.
- **New Waves**: edit the `waves` array in `enemy/Spawner.gd` or load from external resources; each entry defines spawn `time`, `pattern`, `pos` and optional params.
- **Pooling**: `PoolManager` prewarms bullets, enemies and hit effects. Retrieve objects with `PoolManager.get_from_pool(type)` and return with `PoolManager.return_to_pool(node)`.
- **Sound**: emit `GameSignals.play_sfx(&"shoot")` or `&"explosion"` to reuse audio players from `SoundPool`.

## Profiling Tips
Use Godot's **Monitors** (F8) and the **Debugger** to track physics and process time. Toggle visibility of collision shapes via Debug Draw to inspect interactions.
