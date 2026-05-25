extends Node2D

@onready var player = $Player
@onready var hud = $HUD

func _ready() -> void:
	player.focused_item_changed.connect(_on_player_focused_item_changed)
	player.interacted_with_item.connect(_on_player_interacted_with_item)

func _on_player_focused_item_changed(item) -> void:
	if item == null:
		hud.hide_prompt()
	else:
		hud.show_prompt(item)

func _on_player_interacted_with_item(item) -> void:
	if item == null:
		return

	hud.show_item_details(item.get_display_data())
