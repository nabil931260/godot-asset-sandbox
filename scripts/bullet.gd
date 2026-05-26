extends Area2D

@export var speed: float = 640.0
@export var lifetime: float = 0.7
@export var damage: int = 1
@export var impact_effect_scene: PackedScene

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

	_spawn_impact_effect()
	queue_free()

func _spawn_impact_effect() -> void:
	if impact_effect_scene == null:
		return

	var effect := impact_effect_scene.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.setup(global_position, Color(1, 0.86, 0.25, 1))
