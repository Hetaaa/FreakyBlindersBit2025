extends RigidBody3D
class_name SlowableRigidbody
var time_freeze_factor : float = 0
var saved_dir : bool = false
var saved_velocity = Vector3.ZERO
var saved_angular = Vector3.ZERO
func _ready() -> void:
	pass
func _physics_process(_delta):
	if Global.time_freeze:
		if !saved_dir:
			saved_dir = true
			saved_velocity = linear_velocity
			saved_angular = angular_velocity
		soft_freeze(self)
	else:
		if Global.just_unfreezed:
			Global.just_unfreezed = false
			unfreeze(self)
			saved_dir = false
func soft_freeze(body: RigidBody3D):
	body.gravity_scale = 0
	# spowalnia stopniowo
	body.linear_velocity *= 0.9
	body.angular_velocity *= 0.9
	#print("soft_freeze")
	if body.linear_velocity.length() < 0.01:
		hard_freeze(body)

func hard_freeze(body: RigidBody3D):
	body.linear_velocity = Vector3.ZERO
	body.angular_velocity = Vector3.ZERO
	body.gravity_scale = 0
	body.linear_damp = 1000
	body.angular_damp = 1000
	#print("hard_freeze")
func unfreeze(body: RigidBody3D):
	body.gravity_scale = 1
	body.linear_damp = 0
	body.angular_damp = 0
	body.linear_velocity = saved_velocity
	body.angular_velocity = saved_angular
	#print("unfreeze", body.linear_velocity)
