extends ColorRect

var death_flash_flag: bool = false
var darken_screen_flag: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# if death flash flag is true
	if death_flash_flag:
		self.color.a -= 1.0 * (delta / 2) # smoothly transition opacity back to zero in 1/2 second interval
		
		# once opacity is back to zero, reset flag
		if self.color.a <= 0.01:
			self.color.a = 0
			death_flash_flag = false
			
	# if darken screen flag is true
	if darken_screen_flag:
		self.color.a += 0.5 * delta # smoothly transition up opacity at a rate of 50% / second
		
		# once opacity reaches 30%, reset flag
		if self.color.a >= 0.3:
			darken_screen_flag = false

# causes a flash when the player dies
func flash() -> void:
	print("called flash")
	self.set_color(Color(255, 255, 255, .5)) # set color to white full opacity
	death_flash_flag = true
	
# darkens the screen
func darken_screen() -> void:
	print("called darken")
	self.set_color(Color(0, 0, 0, 0)) # set color to black at zero opacity
	darken_screen_flag = true
	
# resets opacity to zero
func reset() -> void:
	self.set_color(Color(1, 1, 1, 0))
