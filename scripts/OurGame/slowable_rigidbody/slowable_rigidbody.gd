extends RigidBody3D
class_name SlowableRigidbody
var saved_dir : bool = false
var saved_velocity = Vector3.ZERO
var saved_angular = Vector3.ZERO
var unfreezed : bool =false
var freeze_timer = 0
@export var speed = 40.0

var slowing_val : float = 0.9

func _ready() -> void:
	pass
func PhysicsUpdate(delta):
	pass
func _physics_process(delta):
	if freeze_timer>0:
		freeze_timer -= 1
	if Global.time_freeze and freeze_timer> 0:
		if !saved_dir:
			saved_dir = true
			
			saved_velocity = linear_velocity
			saved_angular = angular_velocity
		soft_freeze()
	else:
		if Global.just_unfreezed and !unfreezed:
			unfreezed = true
			unfreeze()
			saved_dir = false
			await get_tree().create_timer(0.1,false).timeout
			Global.just_unfreezed = false
			unfreezed = false
	PhysicsUpdate(delta)
func soft_freeze():
	gravity_scale = 0
	# spowalnia stopniowo
	linear_velocity *= slowing_val
	angular_velocity *= slowing_val
	print("soft_freeze", freeze)
	if linear_velocity.length() < 0.05:
		hard_freeze()

func hard_freeze():
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	gravity_scale = 0
	linear_damp = 1000
	angular_damp = 1000
	#print("hard_freeze")
func unfreeze():
	gravity_scale = 1
	linear_damp = 0
	angular_damp = 0
	linear_velocity = saved_velocity
	angular_velocity = saved_angular
	#print("unfreeze", body.linear_velocity)
func launch(direction: Vector3, initial_speed: float = -1.0) -> void:
	if initial_speed <= 0:
		initial_speed = speed
	# ustaw prędkość bezpośrednio (bez ryzyka związanego z kolejnością _ready)
	linear_velocity = direction.normalized() * initial_speed
