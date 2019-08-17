extends GridMap

var _tileset

#func _ready():
var time: float = 0

func _process(delta):
	time += delta
	if time >= 1:
		time -= 1
		#set_cell_item(rand_range(-5, 5), 0,  rand_range(-5, 5), rand_range(0,3))                        