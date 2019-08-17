extends CollisionShape

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	
func _process(delta):
	self.transform.origin = get_parent().transform.origin
