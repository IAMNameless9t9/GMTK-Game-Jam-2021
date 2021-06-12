extends KinematicBody2D

enum Directions {
	None,
	Left,
	Right,
	Up,
	Down
}

onready var PositionLabel = $CanvasLayer/Label
onready var BarrierCollider = $Area2D/CollisionShape2D
onready var LeftTrans = $Area2D/Left
onready var RightTrans = $Area2D/Right
onready var CenterTrans = $Area2D/Center
onready var UpTrans = $Area2D/Up
onready var DownTrans = $Area2D/Down

var ParentNode = null
var ParentPos = Vector2()


##MOVEMENT VARIABLES
export var MovementSpeed = 32 * 5
export var CurrentDirection = Directions.None
var velocity = Vector2.ZERO

var Arrived = true
var GoTowardsOwner = false
var GoAwayFromOwner = false

##STARTING POSITION
var Spawnpoint = Vector2()
var StartingY = 672
var StartingX = 608

func _ready():
	Spawnpoint = Vector2(StartingX, StartingY)
	position = Spawnpoint
	BarrierCollider.position = CenterTrans.position
	
	ParentNode = get_parent().get_node("Owner")
	ParentPos = ParentNode.position

func _physics_process(delta):
	
	ParentPos = ParentNode.position
	
	velocity = Vector2.ZERO
	if GoTowardsOwner:
		velocity = position.direction_to(ParentPos) * MovementSpeed
	if GoAwayFromOwner:
		velocity = position.direction_to(ParentPos) * -MovementSpeed
	velocity = move_and_slide(velocity)

func _process(delta):
	
	PositionLabel.text = "DogPosition\nX: " + str(position.x) + "\nY: " + str(position.y)
	
	_get_input()
	
	#if CurrentDirection == Directions.Left:
	#	X -= MovementSpeed * delta
	#if CurrentDirection == Directions.Right:
	#	X += MovementSpeed * delta
	#if CurrentDirection == Directions.Down:
	#	Y += MovementSpeed * delta
	#if CurrentDirection == Directions.Up:
	#	Y -= MovementSpeed * delta
		
func _get_input():
	if Input.is_action_pressed("up"):
		GoTowardsOwner = true
		GoAwayFromOwner = false
		BarrierCollider.position = UpTrans.position	
	if Input.is_action_pressed("down"):
		GoTowardsOwner = false
		GoAwayFromOwner = true
		BarrierCollider.position = DownTrans.position	
	if Input.is_action_pressed("stop"):
		GoTowardsOwner = false
		GoAwayFromOwner = false
		BarrierCollider.position = CenterTrans.position				
		
#Barrier Checks
func _on_Area2D_body_entered(body):
	if body.is_in_group("Barrier"):
		CurrentDirection = Directions.None
		BarrierCollider.position = CenterTrans.position
	
	


