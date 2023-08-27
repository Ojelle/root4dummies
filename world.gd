extends Node2D

var IsClearingLinked

@onready var buttons = $Buttons
@onready var clearing_1 = $Clearing1
@onready var clearing_2 = $Clearing2
@onready var clearing_3 = $Clearing3
@onready var clearing_4 = $Clearing4

var currentClearing


# Called when the node enters the scene tree for the first time.
func _ready():
	
	clearing_1.verbindingen = [clearing_2,clearing_3]
	clearing_2.verbindingen = [clearing_1,clearing_3,clearing_4]
	clearing_3.verbindingen = [clearing_1,clearing_2,clearing_4]
	clearing_4.verbindingen = [clearing_2,clearing_3]
	
	buttons.sig_recruit.connect(recruit)
	buttons.sig_move.connect(move)
	
	clearing_1.sig_pressed.connect(pressed_clearing)
	clearing_2.sig_pressed.connect(pressed_clearing)
	clearing_3.sig_pressed.connect(pressed_clearing)
	clearing_4.sig_pressed.connect(pressed_clearing)
	
	currentClearing = clearing_1	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_1"):
		var TempTest = $Clearing1
		var DidIGetInput = 1
		print("al tot hier")
	
	
func recruit():
	currentClearing.change_warrior(1)
	
func destroy():
#	currentClearing.remove_warrior()
	pass

var moveInProgress = false
func move():
	moveInProgress = true
	
func pressed_clearing(clearing):
	if(moveInProgress):
		clearing.move_from(currentClearing, 1)	
		moveInProgress = false
	else:
		currentClearing = clearing
	
func TestMetPrint():
	print("TestMetPrint")

func ApplyMoveBetweenClearings(ClearingA,ClearingB):
	if CheckIsClearingConnected(ClearingA,ClearingB)==false:
		print("clearings not connected")
		return
	#check child - if warriors present in 'from clearing', otherwise break, if present ask how much
	
	var deltaX = ClearingB.global_position[0]-ClearingA.global_position[0]
	var deltaY = ClearingB.global_position[1]-ClearingA.global_position[1]
#	$MarquiseDeCatWarrior2.move_local_x(deltaX)
#	$MarquiseDeCatWarrior2.move_local_y(deltaY)
		
			
			
func CheckIsClearingConnected(clearingA,clearingB):
	if clearingA.verbindingen.find(clearingB) != -1:
		return true
	else:
		return false
		

func GetUserInput(): #eventjes niet gebruikt, specifieker gemaakt naar 'ask for clearing'
	var UserInput = "hihi"
	var DidIGetInput = 0
	
	while DidIGetInput != 1:
		print("while loop")
		if Input.is_action_just_pressed("ui_1"):
			UserInput = "1"
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_2"):
			UserInput = "2"
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_3"):
			UserInput = "3"	
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_4"):
			UserInput = "4"
			DidIGetInput = 1
	
	return UserInput
			
func AskForClearing():
	var Clearing = $Clearing3
	var DidIGetInput = 0
	print("al tot hier1")
	
	while DidIGetInput != 1:
		print("al tot hier2")
		if Input.is_action_just_pressed("ui_1"):
			Clearing = $Clearing1
			DidIGetInput = 1
			print("al tot hier3")
		if Input.is_action_just_pressed("ui_2"):
			Clearing = $Clearing2
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_3"):
			Clearing = $Clearing3
			DidIGetInput = 1
		if Input.is_action_just_pressed("ui_4"):
			Clearing = $Clearing4
			DidIGetInput = 1
	return Clearing

	#var CurrentInputs = 0
	#while CurrentInputs<NumberOfInputs:


func _on_button_pressed():
	ApplyMoveBetweenClearings($Clearing2,$Clearing3)
	print("MIJNEN NIEUWEN KNOP")
	pass # Replace with function body.


func _on_button_pressed2():
	ApplyMoveBetweenClearings($Clearing3,$Clearing2)
	pass # Replace with function body.
