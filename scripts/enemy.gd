extends CharacterBody2D

@export var speed: float = 95.0
@export var max_health: int = 2
@export var contact_damage: int = 1

var _health: int
var _target: Node2D

func _ready() -> void:
	_health = max_health
	_target = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(_delta: float) -> void:
	if _target == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction := global_position.direction_to(_target.global_position)
	velocity = direction * speed
	move_and_slide()

	if direction.length() > 0.0:
		rotation = direction.angle() + PI / 2.0

func take_damage(amount: int) -> void:
	_health -= amount

	if _health <= 0:
		queue_free()

func _on_contact_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(contact_damage)
