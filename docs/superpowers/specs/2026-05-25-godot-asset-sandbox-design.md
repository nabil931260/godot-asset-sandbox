# Godot Asset Sandbox Design

## Purpose

Build a compact Godot 4 refresher project that demonstrates practical engine workflow without pretending to be a shipped game. The repo should support a truthful claim like: "I used this project to review Godot scene composition, input, collisions, animation states, UI feedback, and asset iteration."

The project should look like a human-built refresher repo: small scope, clear structure, useful notes, rough edges documented honestly, and no inflated claims.

## Product Shape

The project is a top-down 2D asset interaction sandbox. A player can walk around a small workshop/gallery scene, approach objects, press an interaction key, and see object details in a HUD panel.

This is intentionally not a full game. The point is to make the Godot workflow visible: scenes, scripts, collision layers, reusable interactable objects, and lightweight UI.

## Core Features

- Player movement with collision using `CharacterBody2D`.
- Camera follow attached to the player scene.
- Reusable interactable item scene with exported metadata fields.
- Interaction detection through an area node.
- HUD prompt when an interactable is nearby.
- Detail panel that updates when an object is selected.
- Simple animated player state placeholder: idle and walk.
- Compact main scene that feels hand-assembled rather than generated.

## Repository Presentation

The repo should include:

- A practical `README.md` that describes the refresher goal.
- A short `docs/devlog.md` with dated notes about each build step.
- A scoped `docs/next-steps.md` list showing what could be improved later.
- Project files and scripts organized by Godot responsibility.
- Simple original placeholder assets generated as plain SVGs where possible, so the project has visible assets without license ambiguity.

The commit history should be staged in real commits that match the actual work:

1. Design and project framing.
2. Godot project scaffold.
3. Player movement and base scene.
4. Interaction system and HUD.
5. Documentation polish and final verification.

No commit timestamps should be altered and no fake elapsed timeline should be manufactured.

## Architecture

`scenes/main.tscn` owns the playable scene and instantiates the player, interactable objects, and HUD. `scenes/player.tscn` owns player-specific nodes: collision shape, sprite, camera, and interaction sensor. `scenes/interactable_item.tscn` exposes metadata fields that can be configured per instance.

Scripts stay small:

- `scripts/player.gd` handles movement and nearby interactable tracking.
- `scripts/interactable_item.gd` stores object metadata and provides a small display API.
- `scripts/hud.gd` displays the current prompt and item details.
- `scripts/main.gd` connects player interaction signals to the HUD.

## Testing And Verification

Godot projects are best verified by opening and running the scene. Automated tests are out of scope for this small refresher repo, but the project should still include a manual verification checklist:

- Project opens in Godot 4.
- `scenes/main.tscn` runs without script errors.
- Player moves with WASD or arrow keys.
- Interactables show a prompt when approached.
- Pressing interact updates the HUD detail panel.

## Non-Goals

- No full combat system.
- No procedural generation.
- No complex inventory.
- No AI-generated art dump.
- No claims of production game experience.
