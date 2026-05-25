extends Node2D

@export var enemy_scene: PackedScene
@export var time_between_spawns: float = 0.45
@export var time_between_waves: float = 1.5

@onready var player = $Player
@onready var hud = $HUD
@onready var active_doors: Array[Marker2D] = [
	$Doors/NorthDoor,
	$Doors/EastDoor,
]

var _wave_number: int = 0
var _enemies_remaining: int = 0
var _spawns_remaining: int = 0
var _spawn_timer: float = 0.0
var _wave_break_timer: float = 0.0
var _next_door_index: int = 0
var _wave_active: bool = false
var _game_over: bool = false

func _ready() -> void:
	player.focused_item_changed.connect(_on_player_focused_item_changed)
	player.interacted_with_item.connect(_on_player_interacted_with_item)
	player.health_changed.connect(_on_player_health_changed)
	player.defeated.connect(_on_player_defeated)
	_start_next_wave()

func _process(delta: float) -> void:
	if enemy_scene == null or _game_over:
		return

	if _wave_active:
		_update_spawning(delta)
		return

	if _enemies_remaining <= 0:
		_wave_break_timer -= delta
		if _wave_break_timer <= 0.0:
			_start_next_wave()

func _on_player_focused_item_changed(item) -> void:
	if item == null:
		hud.hide_prompt()
	else:
		hud.show_prompt(item)

func _on_player_interacted_with_item(item) -> void:
	if item == null:
		return

	hud.show_item_details(item.get_display_data())

func _on_player_health_changed(current_health: int, max_health: int) -> void:
	hud.update_health(current_health, max_health)

func _on_player_defeated() -> void:
	_game_over = true
	_wave_active = false
	hud.show_game_over(true)

func _start_next_wave() -> void:
	if _game_over:
		return

	_wave_number += 1
	_spawns_remaining = _get_wave_size(_wave_number)
	_enemies_remaining = _spawns_remaining
	_spawn_timer = 0.0
	_wave_active = true
	hud.update_wave_status(_wave_number, _enemies_remaining)

func _update_spawning(delta: float) -> void:
	if _spawns_remaining <= 0:
		_wave_active = false
		return

	_spawn_timer -= delta
	if _spawn_timer > 0.0:
		return

	_spawn_enemy()
	_spawns_remaining -= 1
	_spawn_timer = time_between_spawns

func _spawn_enemy() -> void:
	if _game_over:
		return

	var door := active_doors[_next_door_index % active_doors.size()]
	_next_door_index += 1

	var enemy := enemy_scene.instantiate()
	enemy.global_position = door.global_position + door.global_transform.y * 58.0
	enemy.tree_exited.connect(_on_enemy_removed)
	add_child(enemy)

func _on_enemy_removed() -> void:
	_enemies_remaining = maxi(_enemies_remaining - 1, 0)
	hud.update_wave_status(_wave_number, _enemies_remaining)

	if _enemies_remaining == 0 and not _wave_active:
		_wave_break_timer = time_between_waves

func _get_wave_size(wave_number: int) -> int:
	return 2 + min(wave_number - 1, 5)
