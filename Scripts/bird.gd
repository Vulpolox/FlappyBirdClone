extends CharacterBody2D

# public variables
@export var gravity: float = 500.0 # grav accel
@export var jump_speed: float = -250.0 # changes y velocity to this

#player movement stuff
var terminal_velocity: float = 500.0 # after 1 second of acceleration, terminal velocity is reached

# rotation stuff
var angular_acceleration: float = 6.0 # in degrees per second per second
var angular_velocity: float = 0.0 # in degrees per second
var max_angular_velocity: float = 2.0
var max_rotation_degrees: float = 90.0


# flags
var hit_pipe: bool = false
var hit_ground: bool = false

func _ready():
	pass
	
func _physics_process(delta):
	
	# character is alive
	if not hit_pipe and not hit_ground:
		
		# handle player falling due to gravity
		handle_gravity(delta)
		
		# handle jumping
		if Input.is_action_just_pressed("Flap"):
			jump(delta)
			
		# handle rotation
		handle_rotation(delta)
		
		# update forces on character
		self.move_and_slide()
	
	# character hits a pipe or the ground
	else:
		game_over(delta)
		
		
func handle_gravity(delta) -> void:
	
	# if current velocity is less than terminal velocity
	if self.velocity.y <= terminal_velocity:
		self.velocity.y += gravity * delta # add acceleration to current velocity

func jump(delta) -> void:
	self.velocity.y = jump_speed
	angular_velocity = -3.5
	self.rotation_degrees = 25.0
	

func handle_rotation(delta) -> void:
	
	# if current angular velocity hasn't reached the set maximum
	if angular_velocity <= max_angular_velocity:
		angular_velocity += angular_acceleration * delta # accelerate
	
	# if current rotation is at the maximum and current angular velocity is positive
	if self.rotation_degrees >= max_rotation_degrees and angular_velocity > 0.0:
		angular_velocity = 0.0 # set the velocity to zero so you don't rotate past max
	
	self.rotation_degrees += angular_velocity # increment rotation

func game_over(delta) -> void:
	pass
