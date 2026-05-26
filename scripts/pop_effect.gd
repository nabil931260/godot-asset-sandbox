extends Node2D

@export var lifetime: float = 0.18

var _age: float = 0.0

@onready var burst: Polygon2D = $Burst

func setup(spawn_position: Vector2, tint: Color) -> void:
	global_position = spawn_position
	burst.color = tint

func _process(delta: float) -> void:
	_age += delta
	var progress := clampf(_age / lifetime, 0.0, 1.0)
	scale = Vector2.ONE * lerpf(0.65, 1.35, progress)
	modulate.a = 1.0 - progress

	if _age >= lifetime:
		queue_free()
