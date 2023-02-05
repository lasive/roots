extends Node2D
var current_stem_pos = Vector2(0,-1)
var stems = []
var growing = false
var groth_length = 9
var groth_speed = 10
var mouse_pos =  Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	stems.append(current_stem_pos)
	groth_length -= 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if groth_length <= 0:
		return
	if Input.is_action_just_pressed("move_up"):
		move_tile(Vector2(0, -1))
	elif Input.is_action_just_pressed("move_down"):
		move_tile(Vector2(0, 1))
	elif Input.is_action_just_pressed("move_right"):
		move_tile(Vector2(1, 0))
	elif Input.is_action_just_pressed("move_left"):
		move_tile(Vector2(-1, 0))
		
func move_tile(offset):
	var tilemap = get_node("TileMap")
	var tile_pos = current_stem_pos + offset
	if tilemap.get_cellv(tile_pos) == -1:
		$RayCast2D.position = tilemap.map_to_world(tile_pos)
		var collision = $RayCast2D.is_colliding()
		
		
		
		if collision == true:
			
			current_stem_pos = tile_pos
			var cell = tilemap.get_cellv(tile_pos)
			tilemap.set_cellv(tile_pos, 0)
			tilemap.update_bitmask_region()
			groth_length -= 1
			if groth_length <=0:
				get_parent().get_node("player").stoped_grow()
		
		
#	if Input.is_action_pressed("left_click"):
#
#		var mouse_pos = get_global_mouse_position()
#		var tilemap = get_node("TileMap")
#		var tile_pos = tilemap.world_to_map(mouse_pos - tilemap.global_position)
#		var cell = tilemap.get_cellv(tile_pos)
#		#print(tile_pos)
#		tilemap.set_cellv(tile_pos, 0)
#		tilemap.update_bitmask_region()
	
#		print(cell)
	#if Input.is_action_just_released("left_click"):
	#	growing = false
#	if growing:
#		pass
	
	
#func _input(event):
#	if event is InputEventMouseMotion:
#		mouse_pos = get_global_mouse_position()
#		current_stem_pos_start = current_stem_pos_end

	
