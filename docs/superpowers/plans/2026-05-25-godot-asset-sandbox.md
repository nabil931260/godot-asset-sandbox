# Godot Asset Sandbox Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a compact Godot 4 refresher project that demonstrates scene composition, player movement, collision, interactions, HUD feedback, and practical repo documentation.

**Architecture:** The project uses small Godot scenes with focused scripts. `Main` coordinates player interaction events with the HUD, while `Player` and `InteractableItem` keep their own responsibilities local.

**Tech Stack:** Godot 4 scene files, GDScript, simple SVG placeholder assets, Markdown docs.

---

## File Structure

- `project.godot`: project metadata, main scene, and input map.
- `.gitignore`: ignores Godot imports, editor state, and temporary files.
- `scenes/main.tscn`: playable sandbox scene.
- `scenes/player.tscn`: player character, camera, collision, interaction sensor.
- `scenes/interactable_item.tscn`: reusable interactable item.
- `scenes/ui/hud.tscn`: prompt and detail panel UI.
- `scripts/main.gd`: connects player signals to HUD behavior.
- `scripts/player.gd`: movement, interaction sensing, and interaction signal.
- `scripts/interactable_item.gd`: exported item metadata and display API.
- `scripts/hud.gd`: prompt and selected item detail rendering.
- `assets/sprites/player.svg`: simple player marker asset.
- `assets/sprites/item_crate.svg`: simple interactable item asset.
- `assets/sprites/item_terminal.svg`: simple interactable item asset.
- `assets/sprites/item_poster.svg`: simple interactable item asset.
- `docs/devlog.md`: short human-readable build notes.
- `docs/next-steps.md`: scoped improvements for later.
- `README.md`: project framing, run instructions, controls, and verification checklist.

## Task 1: Project Scaffold

**Files:**
- Create: `.gitignore`
- Create: `project.godot`
- Create: `README.md`
- Create: `docs/devlog.md`

- [ ] **Step 1: Add Godot-focused ignore rules**

Create `.gitignore`:

```gitignore
.godot/
.import/
export.cfg
export_presets.cfg
*.tmp
*.translation
```

- [ ] **Step 2: Add project settings**

Create `project.godot` with `scenes/main.tscn` as the run scene and input actions for `move_up`, `move_down`, `move_left`, `move_right`, and `interact`.

- [ ] **Step 3: Add initial README and devlog**

Create a concise README that frames the repo as a Godot refresher. Create `docs/devlog.md` with the initial design/scaffold note.

- [ ] **Step 4: Commit**

Run:

```powershell
git add .gitignore project.godot README.md docs/devlog.md
git commit -m "chore: scaffold Godot refresher project"
```

## Task 2: Player And Base Scene

**Files:**
- Create: `assets/sprites/player.svg`
- Create: `scripts/player.gd`
- Create: `scenes/player.tscn`
- Create: `scripts/main.gd`
- Create: `scenes/main.tscn`

- [ ] **Step 1: Create a simple player asset**

Create a small SVG with a directional marker. It should be plain and readable, not polished beyond the needs of a refresher.

- [ ] **Step 2: Implement player movement**

Create `scripts/player.gd` using `CharacterBody2D`, exported `speed`, and `_physics_process` movement from input actions.

- [ ] **Step 3: Create player and main scenes**

Create `scenes/player.tscn` with a sprite, collision shape, camera, and interaction area. Create `scenes/main.tscn` with a basic floor, a few walls, and the player instance.

- [ ] **Step 4: Commit**

Run:

```powershell
git add assets/sprites/player.svg scripts/player.gd scripts/main.gd scenes/player.tscn scenes/main.tscn
git commit -m "feat: add player movement sandbox"
```

## Task 3: Interactions And HUD

**Files:**
- Create: `assets/sprites/item_crate.svg`
- Create: `assets/sprites/item_terminal.svg`
- Create: `assets/sprites/item_poster.svg`
- Create: `scripts/interactable_item.gd`
- Create: `scripts/hud.gd`
- Create: `scenes/interactable_item.tscn`
- Create: `scenes/ui/hud.tscn`
- Modify: `scripts/player.gd`
- Modify: `scripts/main.gd`
- Modify: `scenes/main.tscn`

- [ ] **Step 1: Add interactable assets**

Create three simple SVG assets: crate, terminal, poster. These give the scene distinct interaction targets without relying on external art.

- [ ] **Step 2: Implement interactable metadata**

Create `scripts/interactable_item.gd` with exported `item_title`, `item_type`, and `item_notes` fields, plus `get_display_data()`.

- [ ] **Step 3: Implement HUD display**

Create `scripts/hud.gd` with `show_prompt`, `hide_prompt`, and `show_item_details` methods.

- [ ] **Step 4: Wire player interaction**

Update `scripts/player.gd` to track nearby interactables, show prompt state, and emit `focused_item_changed` and `interacted_with_item` signals.

- [ ] **Step 5: Add interactables and HUD to main scene**

Update `scenes/main.tscn` to instance three interactable objects and the HUD. Update `scripts/main.gd` to connect player signals to HUD methods.

- [ ] **Step 6: Commit**

Run:

```powershell
git add assets/sprites/item_crate.svg assets/sprites/item_terminal.svg assets/sprites/item_poster.svg scripts/interactable_item.gd scripts/hud.gd scripts/player.gd scripts/main.gd scenes/interactable_item.tscn scenes/ui/hud.tscn scenes/main.tscn
git commit -m "feat: add interactable asset inspection"
```

## Task 4: Documentation Polish And Verification

**Files:**
- Modify: `README.md`
- Modify: `docs/devlog.md`
- Create: `docs/next-steps.md`

- [ ] **Step 1: Expand README**

Add controls, project structure, practiced concepts, and manual verification checklist.

- [ ] **Step 2: Add devlog notes**

Add concise entries for the scaffold, movement, and interaction work.

- [ ] **Step 3: Add next steps**

Create `docs/next-steps.md` with scoped improvements such as tilemap conversion, animation refinement, and exported build presets.

- [ ] **Step 4: Commit**

Run:

```powershell
git add README.md docs/devlog.md docs/next-steps.md
git commit -m "docs: document refresher workflow"
```

## Verification

Manual verification:

- Open the repo in Godot 4.
- Run `scenes/main.tscn`.
- Confirm player movement with WASD or arrow keys.
- Confirm the HUD prompt appears near each item.
- Confirm pressing `E` updates the item detail panel.

Text verification:

```powershell
git status --short
git log --oneline --decorate -5
```

Expected: clean working tree after the final commit and a readable sequence of project commits.

## Self-Review

The plan covers every design requirement: scaffold, movement, collision, interaction metadata, HUD feedback, documentation, devlog, and scoped next steps. It intentionally avoids fake history, overbuilt systems, and external asset dependencies.
