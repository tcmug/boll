extends Spatial

func _ready():
	var level = ResourceLoader.load("res://levels/Demo.tscn")
	add_child(level.instance())