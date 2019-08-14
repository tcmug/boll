extends Area

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var axis: Vector3
# Called when the node enters the scene tree for the first time.
func _ready():
	axis = Vector3(0, 1, 0)
	axis = axis.normalized()

func _process(delta):
	$Mesh.rotate(axis, 5 * delta)

func _on_Area_body_entered(body):
	Game.emit_signal("pickup", "key")
	queue_free()

