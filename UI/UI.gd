extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("pickup", self, "on_pickup")
	
func on_pickup(what):
	$Inventory.text = what
	if what == "key":
		$Key.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
