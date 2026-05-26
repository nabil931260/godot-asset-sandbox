# Workshop Holdout

A compact Godot 4 refresher project built around a small single-room survival loop.

The player is trapped in a workshop during a drone breach. Drones enter through the room doors in waves, the player clears them with a basic blaster, and the room terminal can spend scrap on small upgrades.

This is intentionally modest. I kept the scope small so the Godot workflow stays visible: scenes, signals, input actions, collision, HUD updates, enemy behavior, and a little progression.

## What It Does

- Spawns enemy waves from room doors.
- Lets the player move, shoot, and take damage.
- Tracks hull health, wave number, remaining drones, and scrap.
- Awards scrap after clearing waves.
- Uses the terminal as a simple upgrade station.
- Keeps a few inspectable room props for flavor and context.

## Controls

- `WASD` or arrow keys: move
- `Space`: shoot
- `E`: inspect/use focused room object
- `1`: upgrade weapon damage at the terminal
- `2`: upgrade fire rate at the terminal
- `3`: upgrade hull at the terminal
- `R`: restart after game over

## Practiced Concepts

- Godot scene composition with instanced scenes
- `CharacterBody2D` movement and collision
- `Area2D`-based interaction detection
- Exported GDScript properties for per-instance metadata
- Signal wiring between player, enemies, main scene, and HUD
- Enemy wave spawning and simple chase behavior
- Player health, damage cooldown, and game-over state
- Terminal upgrade flow using input actions
- Basic `CanvasLayer` HUD layout

## Project Structure

```text
assets/sprites/       Simple original SVG placeholders
docs/                 Devlog and next-step notes
scenes/               Godot scene files
scenes/ui/            HUD scene
scripts/              Focused GDScript files
```

## Requirements

- Godot 4.x

## Run

Open this folder in Godot and run `scenes/main.tscn`.

## Manual Test Checklist

Quick things I check after changes:

- Move around the room and make sure cover blocks movement.
- Shoot drones and confirm hit/death effects show.
- Clear a wave and confirm the next wave starts.
- Watch doors flash before drones spawn.
- Reach wave 3 and confirm a heavier drone appears.
- Clear a wave, use the terminal, and buy one upgrade.
- Let the player lose all hull, then press `R` to restart.
