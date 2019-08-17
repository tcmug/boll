extends RigidBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var camera: Camera
var listeners: Spatial
var onFloor: RayCast
var onWall: Area

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_parent().get_node("Camera")
	Game.connect("pickup", self, "on_pickup")
	listeners = get_node("Probes")
	listeners.set_as_toplevel(true)
	onFloor = listeners.get_node("OnFloor")
	onWall = listeners.get_node("OnWall")
	
	
var movement_impulse: Vector3
var max_impulse: float = 10
var contact_wall: bool = false

func _integrate_forces(state):
	var previous = contact_wall
	contact_wall = false
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)
		normal.y = 0
		if normal.length() > 0.8:
			contact_wall = true

	if contact_wall && previous != contact_wall && !$Hit.is_playing():
		var volume = linear_velocity.length()
		if volume > 0.2:
			volume = clamp(-30 + (volume * 5), -30, -10)
			$Hit.set_volume_db(volume)
			$Hit.play(0)

func _physics_process(delta):
	movement_impulse.y = 0
	movement_impulse.x = clamp(movement_impulse.x, -max_impulse, max_impulse)
	movement_impulse.z = clamp(movement_impulse.z, -max_impulse, max_impulse)
	apply_central_impulse(movement_impulse * 5 * delta)
	movement_impulse = Vector3(0, 0, 0)

func _process(delta):
	listeners.transform.origin = self.transform.origin

func _input(event):
	# Mouse movement & we have contact => apply some force to the ball.
	if event is InputEventMouseMotion && onFloor.is_colliding():
		# print($RayCast.get_collider().name, $RayCast.get_collision_point())
		# Transform mouse x & y movement to camera space so that the 
		# direction of the applied force is in the correct direction.
		var temp = Vector3(event.relative.x, 0, event.relative.y)
		var rot: Transform = camera.get_camera_transform()
		rot = Transform(rot.basis, Vector3(0,0,0))
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
	if velocity.length() > 5 && onFloor.is_colliding():
		if !$Hit.playing:
			$Hit.play(0)
	
	if body.name == "Door":
		if Game.inventory.find("key") != -1:
			$Open.play(0)
			body.open()
		else:
			$Denied.play(0)

