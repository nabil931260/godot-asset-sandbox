extends CharacterBody2D

@export var speed: float = 86.0
@export var max_health: int = 2
@export var contact_damage: int = 1
@export var hit_flash_time: float = 0.08
@export var death_effect_scene: PackedScene

var _health: int
var _target: Node2D
var _hit_flash_remaining: float = 0.0

@onready var body: Polygon2D = $Body

func _ready() -> void:
	_health = max_health
	_target = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(delta: float) -> void:
	if _target == null:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_hit_flash(delta)
		return

	var direction := global_position.direction_to(_target.global_position)
	velocity = direction * speed
	move_and_slide()

	if direction.length() > 0.0:
		rotation = direction.angle() + PI / 2.0

	_update_hit_flash(delta)

func take_damage(amount: int) -> void:
	_health -= amount
	_show_hit_flash()

	if _health <= 0:
		_spawn_death_effect()
		queue_free()

func _on_contact_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(contact_damage)

func _show_hit_flash() -> void:
	body.color = Color(1, 0.86, 0.46, 1)
	_hit_flash_remaining = hit_flash_time

func _update_hit_flash(delta: float) -> void:
	if _hit_flash_remaining <= 0.0:
		return

	_hit_flash_remaining = maxf(_hit_flash_remaining - delta, 0.0)
	if _hit_flash_remaining == 0.0:
		body.color = Color(0.86, 0.16, 0.16, 1)

func _spawn_death_effect() -> void:
	if death_effect_scene == null:
		return

	var effect := death_effect_scene.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.setup(global_position, body.color)
