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
		growing = true
		draw_line(current_stem_pos_start, mouse_pos,Color.black, 50, true)
		print(current_stem_pos_start)
		print(mouse_pos)
	if Input.is_action_just_released("left_click"):
		growing = false
	if growing:
		pass
	
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = get_global_mouse_position()
		current_stem_pos_start = current_stem_pos_end

	
