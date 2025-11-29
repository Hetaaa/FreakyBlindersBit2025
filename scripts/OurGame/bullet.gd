extends SlowableRigidbody

@onready var mesh = $Mesh
@onready var ray = $Ray



func _ready() -> void:
	slowing_val = 0.8
# publiczna funkcja inicjująca pocisk



func PhysicsUpdate(_delta):
	if ray.is_colliding():
		if ray.get_collider().has_method("get_hit"):
			ray.get_collider().get_hit(10)
		#Tu dodać particle

func launch(direction: Vector3, initial_speed: float = -1.0) -> void:
	if initial_speed > 0:
		speed = initial_speed
	var v = direction.normalized() * speed
	linear_velocity = v             # natychmiastowa prędkość (najprostsze)
	# albo: apply_central_impulse(v)  # jeśli wolisz jednorazowy impuls
