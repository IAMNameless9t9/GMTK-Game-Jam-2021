extends Area2D

var tile_size = 16 * 4
var transition_speed = 2
var inputs = {"left": Vector2.LEFT, "right": Vector2.RIGHT}

onready var ray = $RayCast2D
onready var tween = $Tween
onready var fps = $Commander/CanvasLayer/FPS

func _process(delta):
	var framerate = str(Engine.get_frames_per_second())
	fps.text = "FPS: " + framerate

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * (tile_size / 2)
	position.y -= (tile_size)
	
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		##position += inputs[dir] * tile_size
		
		move_tween(dir)
		
func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/transition_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

