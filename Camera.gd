extends Camera

export var orbit_distance: float = 10

# warning-ignore:unused_signal
signal drag

var RAY_LENGTH = 1000
var original_position: Vector3
var target_position: Vector3
var position_interpolate: float = 1
var dragging = false
var tap_click = 0

var mouse_coords: Vector3

func _ready():
	translation = (Vector3(1,1,1).normalized() * orbit_distance)

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

func move_to_look_at(position: Vector3):
	target_position = position - (project_ray_normal(Vector2(0, 0)) * orbit_distance)
	original_position = translation
	position_interpolate = 0

func _process(delta):
	
	var pos = get_parent().get_node("Ball").translation
	move_to_look_at(pos)

	if position_interpolate < 1:
		position_interpolate += delta * 10
		translation = original_position.linear_interpolate(target_position, position_interpolate)



