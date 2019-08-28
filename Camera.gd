extends Camera

export var orbit_height: float = 4

# warning-ignore:unused_signal
signal drag

enum Mode {
  FOLLOW,
  FIXED
}

var  mode = Mode.FOLLOW
var RAY_LENGTH = 1000
var interpolated_target: Vector3

func _ready():
	translation = (Vector3(1,1,1).normalized() * orbit_height)

func get_object_under_mouse():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = project_ray_origin(mouse_pos)
	var ray_to = ray_from + project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = get_world().direct_space_state
	var selection = space_state.intersect_ray(ray_from, ray_to)
	return selection.position

func get_plane_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var point = project_ray_origin(mouse_pos)
	var plane = Plane(Vector3(0, 1, 0), 0)
	var normal = project_ray_normal(mouse_pos)
	var pos = plane.intersects_ray(point, normal)
	if pos:
		return pos
	return Vector3(0,0,0)

func _process(delta):
	var target = Game.Player.translation
	
	# Target position
	if mode == Mode.FOLLOW:
		var camera_plane_origin = target + Vector3(0, orbit_height, 0)
		var current = Vector3(translation.x, orbit_height, translation.z)
		var normal_to_current_pos = (current - camera_plane_origin).normalized()
		var camera_target_pos = camera_plane_origin + (normal_to_current_pos * orbit_height)
		var add = (camera_target_pos - translation) * delta
		look_at_from_position(camera_target_pos + add, Game.Player.translation, Vector3(0, 1, 0))
	elif mode == Mode.FIXED:
		var camera_target_pos = target + Vector3(orbit_height, orbit_height, orbit_height)
		var add = (camera_target_pos - translation) * delta
		look_at_from_position(camera_target_pos + add, Game.Player.translation, Vector3(0, 1, 0))


