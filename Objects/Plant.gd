extends Node2D
var current_stem_pos_start = Vector2(0,0)
var current_stem_pos_end = Vector2(0,0)
var growing = false
var groth_length = 1000
var groth_speed = 10
var mouse_pos =  Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_click"):
		
		var mouse_pos = get_global_mouse_position()
		var tilemap = get_node("TileMap")
		var tile_pos = tilemap.world_to_map(mouse_pos - tilemap.global_position)
		var cell = tilemap.get_cellv(tile_pos)
		print(cell)
		tilemap.set_cellv(tile_pos, 0)
		tilemap.update_bitmask_region()
#		print(cell)
	#if Input.is_action_just_released("left_click"):
	#	growing = false
#	if growing:
#		pass
	
#func _input(event):
#	if event is InputEventMouseMotion:
#		mouse_pos = get_global_mouse_position()
#		current_stem_pos_start = current_stem_pos_end

	
