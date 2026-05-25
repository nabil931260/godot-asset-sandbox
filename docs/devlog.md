# Devlog

## 2026-05-25 - Project framing

Started this as a focused Godot 4 refresher rather than a full game. The goal is to review the parts of the engine I would expect to touch in asset-heavy workflow tasks: scenes, scripts, collision, UI, and iteration notes.

## 2026-05-25 - Scaffold

Added the base Godot project settings, input map, ignore rules, and initial README. Kept the language plain because this repo should read like a working refresher project, not a portfolio landing page.

## 2026-05-25 - Player slice

Added a playable scene with `CharacterBody2D` movement, a camera, wall collision, and a simple SVG player marker. I kept the scene hand-assembled instead of building a bigger tilemap system on the first pass.

## 2026-05-25 - Interaction slice

Added a reusable interactable item scene, three small SVG object markers, and a HUD that updates from player signals. The useful pattern here is the exported metadata on each item instance: the script stays the same while the placed assets carry different notes.

## 2026-05-25 - Documentation pass

Expanded the README with controls, practiced concepts, and manual verification steps. Added next-step notes separately so the main README does not pretend the project is more finished than it is.

## 2026-05-25 - Direction change

Decided to turn the sandbox into a small single-room survival game. This should make the project more interesting while still keeping it realistic for a refresher repo. The new direction is a workshop holdout: enemies enter through doors, the player shoots with Space, and the existing props become part of the room fiction.

I am saving the terminal upgrade idea for later. It makes sense as an upgrade station, but only after the basic movement, shooting, enemy, wave, and health loops work.
