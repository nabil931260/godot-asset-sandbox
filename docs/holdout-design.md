# Workshop Holdout Design Notes

## Direction

The project is shifting from a static asset-inspection sandbox into a small single-room survival game. I still want it to read like a Godot refresher project, so the scope stays compact: one room, a few doors, a simple weapon, basic enemies, and UI that explains what is happening.

Working title: **Workshop Holdout**

## Core Loop

The player is stuck in a maintenance room during a drone breach. Enemies enter through room doors in short waves. The player moves, shoots, uses cover, and tries to clear each wave.

The loop should be easy to understand:

1. Wave starts.
2. Enemies spawn from the doors.
3. Player moves and shoots.
4. Enemies chase the player.
5. Wave ends when all enemies are gone.
6. The room gives the player a moment to breathe before the next wave.

The first version does not need a full upgrade economy, pathfinding, or polished art. It needs a working loop that feels like a real small game instead of a tech demo.

## Controls

- `WASD` or arrow keys: move
- `Space`: shoot
- `E`: interact with room objects

## Room

The game takes place in a single rectangular workshop room. The room should have:

- Two doors for the first version.
- Space for up to four doors later.
- A few cover blocks or workbenches.
- Three readable room props:
  - Emergency Supply Crate
  - Room Control Terminal
  - Safety Poster

The room should be simple enough to read at a glance. The goal is not level-design complexity; the goal is to show scene composition, collision, spawn points, and HUD feedback.

## Enemies

Enemies are malfunctioning maintenance drones. They do not need much personality yet. For the first pass, they just need to be easy to read and clearly dangerous:

- Spawn at door markers.
- Move toward the player.
- Damage the player on contact.
- Disappear when health reaches zero.

The first enemy type can be the only enemy type. Later variants are optional.

## Player Weapon

The player starts with a basic blaster.

Initial behavior:

- Shoots one projectile at a time using `Space`.
- Projectile travels in the player's facing direction.
- Projectile damages or destroys enemies.
- A small fire cooldown prevents constant bullet spam.

This is enough to prove the shooting loop without building a full combat system.

## HUD

The HUD should show:

- Player health.
- Current wave.
- Enemies remaining.
- Interaction prompt.
- Object details when inspecting props.

The HUD should stay practical and readable. No big decorative overlay is needed.

## Object Descriptions

The existing inspectable objects should read like they belong in the room:

### Emergency Supply Crate

Stamped with faded hazard tape. Most of the useful parts are gone, but the reinforced lid still makes decent cover.

### Room Control Terminal

The diagnostic screen loops the same warning: EXTERNAL LOCKDOWN ACTIVE. Someone sealed this room before the breach.

### Safety Poster

A cheerful reminder to report malfunctioning drones. Someone crossed out "report" and wrote "run."

## Later Upgrade Slice

The terminal can become the upgrade station after the first combat loop works.

Possible upgrade behavior:

- Player earns scrap from clearing waves.
- Pressing `E` at the terminal opens a small upgrade panel.
- Upgrade options:
  - Weapon damage
  - Fire rate
  - Armor / max health
- Keep upgrades simple and visible in the HUD.

This should come after movement, shooting, enemies, waves, and health are stable. If added too early, it will distract from proving the core loop.

## Build Slices

1. Update docs and game direction.
2. Shape the single-room arena.
3. Add player shooting.
4. Add enemy movement and bullet damage.
5. Add wave spawning from doors.
6. Add player health and game over.
7. Update object descriptions and README.
8. Add terminal upgrade station if the base loop feels good.

Each slice should be committed and pushed separately so GitHub always has a safe version.
