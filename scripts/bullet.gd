extends Area2D

@export var speed: float = 520.0
@export var lifetime: float = 0.85
@export var damage: int = 1

var direction: Vector2 = Vector2.RIGHT
var _age: float = 0.0

func setup(spawn_position: Vector2, travel_direction: Vector2) -> void:
	global_position = spawn_position
	direction = travel_direction.normalized()
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	_age += delta

	if _age >= lifetime:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

	queue_free()
