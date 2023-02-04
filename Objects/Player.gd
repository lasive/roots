extends KinematicBody2D
var velocity = Vector2.ZERO
export var speed = 20
export var maxSpeedY = 1000
export var maxSpeedX = 100
export var jump_speed = -100
export var gravity = 500
var directionX = 1
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
	
	$letterE_L.hide()
	$letterE_R.hide()
	
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
	if is_on_floor():
		var tilemap = get_parent().get_node("TileMap")
		var aproximate_position = Vector2(global_position.x + directionX*16, global_position.y + 16)
		draw_circle(aproximate_position, 2, Color.black)
		var cell_pos = tilemap.world_to_map(aproximate_position)
		#print(tile_pos)
		var cell = tilemap.get_cellv(cell_pos)
		if cell == 3:
			
			if Input.is_action_just_pressed("E"):
				var seed_pos = tilemap.map_to_world(cell_pos)
				var cell_size = tilemap.cell_size.x
				var corrected_seed_pos = Vector2(seed_pos.x + cell_size/2, seed_pos.y - cell_size/2)
				get_parent().plant_seed(corrected_seed_pos)
				print(cell_pos)
			#print(cell)
			if directionX >= 0:
				$letterE_R.show()
			else:
				$letterE_L.show()

		
		
#	if Input.is_action_just_pressed("left_click"):
#		print(0)
#		var mouse_pos = get_global_mouse_position()
#		var tilemap = get_parent().get_node("TileMap")
#		var tile_pos = tilemap.world_to_map(mouse_pos)
#		var cell = tilemap.get_cellv(tile_pos)
#		print(tile_pos)
#		print(cell)
