extends Node2D
var plant_scene = preload("res://Objects/Plant.tscn")
var plant = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func plant_seed(tile_pos):
	var p = plant_scene.instance()
	add_child(p)
	p.global_position = tile_pos
	plant = p

func deplant():
	plant.queue_free()
