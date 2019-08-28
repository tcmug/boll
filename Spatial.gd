extends Spatial

func _ready():
	Game.Player = get_node("/root/InGame/Ball")
	var level = ResourceLoader.load("res://levels/Demo.tscn")
	add_child(level.instance())