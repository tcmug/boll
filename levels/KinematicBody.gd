extends KinematicBody

var velocity: Vector3

func _physics_process(delta):
	var gravity = Vector3(0, -9.8, 0)
	
	if !is_on_floor():
		velocity += gravity * delta
	else:
		velocity.y = 0
	var dir_vector: Vector3
	if (Game.Player.translation - translation).length() < 5:
		look_at(Game.Player.translation, Vector3(0, 1, 0))
		dir_vector = get_global_transform().basis.z
		$Geezer/AnimationTree.set("parameters/Walk/blend_amount", 1)
	else:
		$Geezer/AnimationTree.set("parameters/Walk/blend_amount", 0)
		
	var temp_velocity = velocity - dir_vector
	move_and_slide(temp_velocity, Vector3(0, 1, 0))