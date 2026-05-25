# Next Steps

These are small improvements I would make if I kept extending the refresher.

## Scene And Assets

- Convert the hand-placed floor and walls into a small TileMap.
- Add one-frame idle/walk animation placeholders instead of rotating the marker.
- Add an `assets/source/` folder if the placeholder art starts needing editable source files.

## Interaction

- Sort nearby interactables by distance when more than one object overlaps the sensor.
- Add a light outline or highlight to the focused object.
- Add a second interaction type, such as toggling a terminal state.

## Packaging

- Add an export preset after testing on a clean Godot install.
- Record a short GIF for the README once the scene has final layout polish.

## Testing

- Add a small manual test checklist per release tag.
- Consider a GUT test only if the interaction logic grows beyond simple signal wiring.
