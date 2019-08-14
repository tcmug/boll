extends Node

onready var Player = get_node("/root/Spatial/Ball")
signal pickup

var inventory: Array

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	connect("pickup", self, "on_pickup")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("reload"):
		inventory = []
		get_tree().reload_current_scene()

func on_pickup(type):
	print(inventory)
	inventory.push_back(type)