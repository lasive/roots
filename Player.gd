extends KinematicBody2D
var velocity = Vector2.ZERO
export var speed = 50
export var maxSpeedY = 5000
export var maxSpeedX = 300
export var jump_speed = -600
export var gravity = 1000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input(delta):
	
	if abs(velocity.x) < 50:
		velocity.x = 0
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
	
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, maxSpeedY)
	if is_on_floor():
		velocity.y = 0
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			print(2)
		elif  is_on_wall():
			velocity.y = jump_speed
			print(3)
	move_and_slide(velocity,Vector2.UP)
