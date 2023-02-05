extends Node2D
var plant_scene = preload("res://Objects/Plant.tscn")
var plant = null
export var next_scene = "res://Levels/lvl_1.tscn"
export var plant_moves = 8
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
	plant.add_plant_moves(plant_moves)

func deplant():
	plant.queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "player":
		get_tree().change_scene(next_scene)


func _on_Fall_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
