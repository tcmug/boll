extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera: Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent().get_node("Camera")
	Game.connect("pickup", self, "on_pickup")
	
var movement_impulse: Vector3
var max_impulse: float = 10

func _physics_process(delta):
	movement_impulse.y = 0
	movement_impulse.x = clamp(movement_impulse.x, -max_impulse, max_impulse)
	movement_impulse.z = clamp(movement_impulse.z, -max_impulse, max_impulse)
	apply_central_impulse(movement_impulse * 5 * delta)
	movement_impulse = Vector3(0, 0, 0)

	
func _input(event):
	if event is InputEventMouseMotion:
		var temp = Vector3(event.relative.x, 0, event.relative.y)
		var rot: Transform = camera.get_camera_transform()
		rot = Transform(rot.basis, Vector3(0,0,0))
		rot = rot.translated(rot.origin * -1)
		temp = rot.xform(temp)
		movement_impulse += temp

func on_pickup(type):
	if type == 'pill':
		$Pill.play(0)
	else:
		$Pickup.play(0)
	print("Got " + type)

func _on_Ball_body_entered(body):
	var velocity = Vector3(linear_velocity.x, 0, linear_velocity.y)
	if velocity.length() > 1 && body.name != "Floor":
		if !$Hit.playing:
			$Hit.play(0)
