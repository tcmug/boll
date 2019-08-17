extends StaticBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var a: float = 1
var state: String = "closed"
var src: Vector3
var dest: Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if state == "opening":
		self.transform.origin = src.linear_interpolate(dest, a)
		a += delta
		if a >= 1:
			state = "open"
	
func open():
	a = 0
	state = "opening"
	src = transform.origin 
	dest = src + Vector3(0, -1, 0)
	$CollisionShape.disabled = true


