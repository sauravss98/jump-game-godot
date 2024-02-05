extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0
@onready var sprite_2d = $Sprite2D
var MAX_JUMP = 2
var JUMP_COUNT = 0
@onready var game_manager = %GameManager

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if Input.is_action_just_pressed("cheat"):
		game_manager.add_point()

	# Animations
	if (velocity.x>1 || velocity.x<-1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "idle" 
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping" 
	
	## normal jump
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	#double jump
	if is_on_floor():
		JUMP_COUNT = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and JUMP_COUNT < MAX_JUMP:
		velocity.y = JUMP_VELOCITY
		JUMP_COUNT+=1;
	
	if Input.is_action_pressed("jump") and is_on_wall():
		velocity.y = JUMP_VELOCITY
		if(Input.is_action_just_pressed("move_left")):
			velocity.x = 500
		elif(Input.is_action_just_pressed("move_right")):
			velocity.x = -500

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)
	

	move_and_slide()

	if velocity.x > 0:
		sprite_2d.flip_h = false
	elif velocity.x <0:
		sprite_2d.flip_h = true
