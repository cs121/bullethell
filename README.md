# Bullet Hell Starter

Godot 4.3+ 2D bullet-hell starter focusing on performance via object and sound pooling.

## Setup

1. Open `project.godot` with Godot 4.3 or newer.
2. Autoloads `GameManager` and `AudioManager` are preconfigured in `project.godot`.
3. Run the project to play the sample mission.

## Project Structure

- `autoload/` – central singletons (`GameManager`, `AudioManager`).
- `background/` – parallax/tilemap background resources.
- `components/` – reusable `HealthComponent`, `MovementComponent`, `WeaponComponent`.
- `effects/` – pooled visual hit effects.
- `enemies/` – enemy scenes using components.
- `player/` – player scene and script.
- `projectiles/` – projectile scene and script.
- `pools/` – generic `ObjectPool` used for projectiles, enemies, effects.
- `hud/` – minimal HUD.
- `missions/` – JSON mission descriptions.

## Extending

- **New enemies**: create a scene with components and add it to a pool. Reference it in mission JSON.
- **New waves**: edit `missions/mission1.json` or add new mission files and call `GameManager.start_mission()` with the path.
- **SFX**: place audio files in `sfx/` and reference them in weapon or effect scripts.

## Pools

`ObjectPool` preloads and recycles nodes to avoid runtime instantiation in hot paths. `AudioManager` maintains a pool of `AudioStreamPlayer2D` nodes for low-cost sound playback. Projectiles, enemies and hit effects request instances from their respective pools and release them when finished.

