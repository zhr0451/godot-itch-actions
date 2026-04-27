extends CharacterBody2D

@export var speed = 400

func _physics_process(_delta):
	# Get input vector based on your Input Map actions
	var direction = Input.get_vector("left", "right", "up", "down")
	
	# Set velocity and move
	velocity = direction * speed
	move_and_slide()
