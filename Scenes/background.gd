extends Node2D

var sky: TileMap
var buildings: TileMap
var sky_scroller: InfiniScroller
var building_scroller: InfiniScroller

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# get references to nodes
	sky = $Sky
	buildings = $Buildings
	
	# initialize InifiniScrollers
	sky_scroller = InfiniScroller.new(sky)
	building_scroller = InfiniScroller.new(buildings)
	
	# set the InfiniScrollers to loop every 1152 pixels
	sky_scroller.set_loop(1152)
	building_scroller.set_loop(1152)
	
	# set the InfiniScrollers' scroll speeds to different values to give illusion of parallax
	sky_scroller.set_scroll_speed(60)
	building_scroller.set_scroll_speed(120)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sky_scroller.loop_and_scroll(delta)
	building_scroller.loop_and_scroll(delta)
