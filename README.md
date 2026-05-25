# Godot Asset Sandbox

A compact Godot 4 refresher project focused on practicing scene composition, input handling, collision, interaction prompts, UI feedback, and asset iteration.

This is a sandbox, not a full game. I kept the scope small so the engine workflow stays visible and easy to review.

## What It Does

The scene is a small top-down workshop/gallery. The player can move around, approach a few objects, and press `E` to inspect them. Each object uses the same reusable interactable scene with different exported metadata and simple placeholder art.

## Controls

- `WASD` or arrow keys: move
- `E`: inspect the focused asset

## Practiced Concepts

- Godot scene composition with instanced scenes
- `CharacterBody2D` movement and collision
- `Area2D`-based interaction detection
- Exported GDScript properties for per-instance metadata
- Signal wiring between player, main scene, and HUD
- Basic `CanvasLayer` HUD layout
- Small original SVG placeholder assets

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
