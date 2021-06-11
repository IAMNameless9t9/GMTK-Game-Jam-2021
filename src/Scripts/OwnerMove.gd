extends KinematicBody2D

var direction = ""
var speed = 60
var tileSize = 25
var held_directions = []

func _ready():
	pass
	
func _physics_process(delta):
	
	for dir in ["left", "right"]:
		var is_pressed = Input.is_action_pressed("ui_"+dir)
		var index_of_direction = held_directions.find(dir)
		if index_of_direction == -1:
			if is_pressed:
				held_directions.push_front(dir)
		else:
			if not is_pressed:
				held_directions.remove(index_of_direction)
				
		if held_directions.size() > 0:
			direction = held_directions[0]
			move_and_slide(_get_movement(direction))
			
func _get_movement(dir):
	var vectors = {
		"left": Vector2(-speed, 0),
		"right": Vector2(speed, 0),
	}
	
	return vectors[direction]

