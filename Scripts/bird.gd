extends CharacterBody2D

# signals
signal start_game

# public variables
@export var gravity: float = 500.0 # grav accel
@export var jump_speed: float = -250.0 # changes y velocity to this

#player movement stuff
var terminal_velocity: float = 500.0 # after 1 second of acceleration, terminal velocity is reached
var bottom_right_coords: Vector2 # for restricting player movement

# rotation stuff
var angular_acceleration: float = 6.0 # in degrees per second per second
var angular_velocity: float = 0.0 # in degrees per second
var max_angular_velocity: float = 2.0 # cannot accelerate past this amount
var max_rotation_degrees: float = 90.0 # cannot rotate player past this amount of degrees

# flags
var started: bool = false
var hit_obstacle: bool = false
var jump_on_death_flag: bool = false

# starting position
var start_pos: Vector2

# starting animation
var current_degrees: float = 0.0

# child node references
var collision_shape

func _ready():
	
	# set reference
	collision_shape = $CollisionShape2D
	
	# for player position restriction
	bottom_right_coords = get_viewport_rect().size + get_viewport_rect().position
	
	# player starting position
	start_pos = Vector2(256.0, bottom_right_coords.y / 2)
	
	# reset things
	reset()


func _physics_process(delta):
	
	# if game has not been started
	if not started:
		
		# play pre game animation
		pre_game_animation(delta)
		
		# check for input to start game
		if Input.is_action_just_pressed("Flap"):
			started = true
			start_game.emit()
			jump()
		
		return
	
	# if character is alive
	elif started and not hit_obstacle:
		
		# handle player falling due to gravity
		handle_gravity(delta)
		
		# handle jumping
		if Input.is_action_just_pressed("Flap"):
			jump()
		
		# handle rotation
		handle_rotation(delta)
		
		# restrict player movement to the visible area
		self.position = self.position.clamp(Vector2.ZERO, bottom_right_coords)
		
		# update forces on character
		self.move_and_slide()
		
	
	# character hits a pipe or the ground
	else:
		
		# play a death animation
		if not jump_on_death_flag:
			jump()
			jump_on_death_flag = true
		
		# make bird fall
		if self.position.y < 700:
			handle_gravity(delta)
			handle_rotation(delta)
			self.move_and_slide()
		
		# remove from player group to prevent further collisions
		self.remove_from_group("player")

# resets the player for a new game
func reset():
	
	self.position = start_pos # set player's starting position
	self.rotation = 0 # reset bird's rotation
	
	# reset flags
	hit_obstacle = false
	started = false
	jump_on_death_flag = false
	
	# reenable collision by adding to the player group
	self.add_to_group("player")
	

# handles the player falling due to gravity
func handle_gravity(delta) -> void:
	
	# if current velocity is less than terminal velocity
	if self.velocity.y <= terminal_velocity:
		self.velocity.y += gravity * delta # add acceleration to current velocity


# handles player jumping
func jump() -> void:
	self.velocity.y = jump_speed  # make the player jump
	angular_velocity = -3.5 # make the player rotate counter clockwise
	self.rotation_degrees = 25.0 # set the player's rotation


# handles rotation animations of the bird
func handle_rotation(delta) -> void:
	
	# if current angular velocity hasn't reached the set maximum
	if angular_velocity <= max_angular_velocity:
		angular_velocity += angular_acceleration * delta # accelerate
	
	# if current rotation is at the maximum and current angular velocity is positive
	if self.rotation_degrees >= max_rotation_degrees and angular_velocity > 0.0:
		angular_velocity = 0.0 # set the velocity to zero so you don't rotate past max
	
	self.rotation_degrees += angular_velocity # increment rotation


# adds an animation to the bird before the game starts
func pre_game_animation(delta):
	
	# increment the degrees
	current_degrees +=  4
	
	# keep current_degrees within reasonable range without changing sin output
	if current_degrees >= 360:
		current_degrees -= 360
	
	self.position.y -= sin(current_degrees * (PI/180))
