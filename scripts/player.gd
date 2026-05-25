extends CharacterBody2D

signal focused_item_changed(item)
signal interacted_with_item(item)

@export var speed: float = 180.0
@export var bullet_scene: PackedScene
@export var fire_cooldown: float = 0.22

var _focused_item: Node = null
var _aim_direction: Vector2 = Vector2.RIGHT
var _cooldown_remaining: float = 0.0

@onready var muzzle: Marker2D = $Muzzle

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

	if direction.length() > 0.0:
		_aim_direction = direction.normalized()
		rotation = direction.angle() + PI / 2.0

	_cooldown_remaining = maxf(_cooldown_remaining - delta, 0.0)

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
	bullet.setup(muzzle.global_position, _aim_direction)
	_cooldown_remaining = fire_cooldown
