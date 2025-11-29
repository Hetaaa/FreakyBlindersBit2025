extends SlowableRigidbody

const SPEED = 40.0

@onready var mesh = $Mesh
@onready var ray = $Ray


func _ready() -> void:
	slowing_val = 0.8
# publiczna funkcja inicjująca pocisk

func _physics_process(_delta):
	if ray.is_colliding():
		if ray.get_collider().has_method("get_hit"):
			ray.get_collider().get_hit(10)
		#Tu dodać particle

func launch(direction: Vector3, initial_speed: float = -1.0) -> void:
	if initial_speed <= 0:
		initial_speed = SPEED
	# ustaw prędkość bezpośrednio (bez ryzyka związanego z kolejnością _ready)
	linear_velocity = direction.normalized() * initial_speed
	freeze_timer = 30
