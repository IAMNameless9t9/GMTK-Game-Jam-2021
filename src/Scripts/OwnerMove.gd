extends KinematicBody2D

enum Directions {
	None,
	Left,
	Right
}

export var CanMove = true

onready var PositionLabel = $CanvasLayer/Label
onready var BarrierCollider = $Area2D/CollisionShape2D
onready var LeftTrans = $Area2D/Left
onready var RightTrans = $Area2D/Right
onready var CenterTrans = $Area2D/Center


##MOVEMENT VARIABLES
export var MovementSpeed = 64 * 4
export var CurrentDirection = Directions.None
var velocity = Vector2.ZERO

var Arrived = true

##STARTING POSITION
var Spawnpoint = Vector2()
var StartingY = -64
var StartingX = 512

func _ready():
	Spawnpoint = Vector2(StartingX, StartingY)
	position = Spawnpoint
	BarrierCollider.position = CenterTrans.position
	
func _physics_process(delta):
	
	var X = position.x
	
	if CurrentDirection == Directions.Left:
		X -= MovementSpeed * delta
	if CurrentDirection == Directions.Right:
		X += MovementSpeed * delta
		
	position = Vector2(X,StartingY)
	
	velocity = Vector2.ZERO
	velocity = position.direction_to(Vector2(X,StartingY)) * MovementSpeed
	velocity = move_and_slide(velocity)
	
func _process(delta):
	
	PositionLabel.text = "OwnPosition\nX: " + str(position.x) + "\nY: " + str(position.y)
	
	if CanMove:
		_get_input()
		
func _get_input():
	if Input.is_action_pressed("left"):
		CurrentDirection = Directions.Left
		BarrierCollider.position = LeftTrans.position
	if Input.is_action_pressed("right"):
		CurrentDirection = Directions.Right	
		BarrierCollider.position = RightTrans.position
	if Input.is_action_just_released("left"):
		CurrentDirection = Directions.None
		BarrierCollider.position = CenterTrans.position
	if Input.is_action_just_released("right"):
		CurrentDirection = Directions.None
		BarrierCollider.position = CenterTrans.position


#Barrier Checks
func _on_Area2D_body_entered(body):
	if body.is_in_group("Barrier"):
		CurrentDirection = Directions.None
		BarrierCollider.position = CenterTrans.position
