extends KinematicBody2D
var velocity = Vector2.ZERO
export var speed = 20
export var maxSpeedY = 1000
export var maxSpeedX = 100
export var jump_speed = -100
export var gravity = 500
var directionX = 1
var planted = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input(delta):
	
	if abs(velocity.x) < 10:
		velocity.x = 0
	else:
		directionX = sign(velocity.x)
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
	else:
		velocity.x -= sign(velocity.x)*speed
	if abs(velocity.x) > maxSpeedX:
		velocity.x = sign(velocity.x)*maxSpeedX
		
func _physics_process(delta: float) -> void:
	get_input(delta)
	
	$E.hide()
	
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, maxSpeedY)
	if is_on_floor():
		velocity.y = min(50, velocity.y)
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
		elif  is_on_wall():
			velocity.y = jump_speed
	move_and_slide(velocity,Vector2.UP)
	if is_on_floor() and not planted:
		var tilemap = get_parent().get_node("TileMap")
		var cell_size = tilemap.cell_size.x
		var aproximate_position = Vector2(global_position.x + directionX*cell_size*1.5, global_position.y + cell_size)
		var aproximate_position_top = Vector2(global_position.x + directionX*cell_size*1.5, global_position.y + cell_size - cell_size)
		var aproximate_position_top_top = Vector2(global_position.x + directionX*cell_size*1.5, global_position.y + cell_size - cell_size - cell_size)
		
		var cell = tilemap.get_cellv(tilemap.world_to_map(aproximate_position))
		var cell_top = tilemap.get_cellv(tilemap.world_to_map(aproximate_position_top))
		var cell_top_top = tilemap.get_cellv(tilemap.world_to_map(aproximate_position_top_top))
		print(cell)
		var plant_pos = Vector2.ZERO
		if cell == 3 and cell_top == -1:
			plant_pos = plant_seed(tilemap, aproximate_position)
			
		elif cell_top == 3 and cell_top_top == -1:
			plant_pos = plant_seed(tilemap, aproximate_position_top)
			print(plant_pos)
		if plant_pos.x != 0:
			$E.show()
			$E.global_position = plant_pos
	elif planted == true:
		if Input.is_action_just_pressed("E"):
			get_parent().deplant()
			planted = false
		
func plant_seed(tilemap, pos) -> Vector2:
	var cell_size = tilemap.cell_size.x
	var cell_pos = tilemap.world_to_map(pos)
	var seed_pos = tilemap.map_to_world(cell_pos)
	
	var corrected_seed_pos = Vector2(seed_pos.x + cell_size/2, seed_pos.y + cell_size/2)
	if Input.is_action_just_pressed("E"):
		get_parent().plant_seed(corrected_seed_pos)
		planted = true
	#print(cell_pos)
	return Vector2(seed_pos.x + cell_size/2, seed_pos.y - cell_size/2)
#	if Input.is_action_just_pressed("left_click"):
#		print(0)
#		var mouse_pos = get_global_mouse_position()
#		var tilemap = get_parent().get_node("TileMap")
#		var tile_pos = tilemap.world_to_map(mouse_pos)
#		var cell = tilemap.get_cellv(tile_pos)
#		print(tile_pos)
#		print(cell)
