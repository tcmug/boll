extends StaticBody

enum State {
	CLOSED,
	OPENING,
	OPEN
}

var a: float = 1
var state = State.CLOSED
var src: Vector3
var dest: Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if state == State.OPENING:
		self.transform.origin = src.linear_interpolate(dest, a)
		a += delta
		if a >= 1:
			state = State.OPEN
			$CollisionShape.disabled = true
	
func open():
	a = 0
	$Open.play(0)
	state = State.OPENING
	src = transform.origin 
	dest = src + Vector3(0, -1, 0)

func _on_Area_body_entered(body):
	if state == State.CLOSED && body.name == "Ball":
		if Game.inventory.find("key") != -1:
			self.open()
		else:
			$Denied.play(0)
