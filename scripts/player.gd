extends CharacterBody2D

signal focused_item_changed(item)
signal interacted_with_item(item)
signal health_changed(current_health, max_health)
signal defeated

@export var speed: float = 180.0
@export var bullet_scene: PackedScene
@export var fire_cooldown: float = 0.22
@export var muzzle_flash_time: float = 0.07
@export var max_health: int = 5
@export var damage_cooldown: float = 0.75
@export var weapon_damage: int = 1

var _focused_item: Node = null
var _aim_direction: Vector2 = Vector2.UP
var _cooldown_remaining: float = 0.0
var _flash_remaining: float = 0.0
var _damage_cooldown_remaining: float = 0.0
var _current_health: int

@onready var muzzle: Marker2D = $Muzzle
@onready var muzzle_flash: Polygon2D = $Muzzle/MuzzleFlash

func _ready() -> void:
	_current_health = max_health
	health_changed.emit(_current_health, max_health)

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if direction.length() > 0.0:
		_aim_direction = direction.normalized()
		rotation = direction.angle() + PI / 2.0

	_cooldown_remaining = maxf(_cooldown_remaining - delta, 0.0)
	_damage_cooldown_remaining = maxf(_damage_cooldown_remaining - delta, 0.0)
	_update_muzzle_flash(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _focused_item != null:
		interacted_with_item.emit(_focused_item)
		get_viewport().set_input_as_handled()

	if event.is_action_pressed("shoot"):
		_try_fire()
		get_viewport().set_input_as_handled()

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.has_method("get_display_data"):
		_set_focused_item(body)

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body == _focused_item:
		_set_focused_item(null)

func _set_focused_item(item: Node) -> void:
	if _focused_item == item:
		return

	_focused_item = item
	focused_item_changed.emit(_focused_item)

func _try_fire() -> void:
	if bullet_scene == null or _cooldown_remaining > 0.0:
		return

	var bullet := bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.damage = weapon_damage
	bullet.setup(muzzle.global_position, _aim_direction)
	_show_muzzle_flash()
	_cooldown_remaining = fire_cooldown

func take_damage(amount: int) -> void:
	if amount <= 0 or _damage_cooldown_remaining > 0.0 or _current_health <= 0:
		return

	_current_health = maxi(_current_health - amount, 0)
	_damage_cooldown_remaining = damage_cooldown
	health_changed.emit(_current_health, max_health)

	if _current_health == 0:
		defeated.emit()
		set_physics_process(false)

func upgrade_weapon_damage() -> void:
	weapon_damage += 1

func upgrade_fire_rate() -> void:
	fire_cooldown = maxf(fire_cooldown - 0.04, 0.1)

func upgrade_hull() -> void:
	max_health += 1
	_current_health = mini(_current_health + 1, max_health)
	health_changed.emit(_current_health, max_health)

func _show_muzzle_flash() -> void:
	muzzle_flash.visible = true
	_flash_remaining = muzzle_flash_time

func _update_muzzle_flash(delta: float) -> void:
	if _flash_remaining <= 0.0:
		return

	_flash_remaining = maxf(_flash_remaining - delta, 0.0)
	muzzle_flash.visible = _flash_remaining > 0.0
